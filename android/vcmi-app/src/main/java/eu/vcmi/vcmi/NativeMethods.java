package eu.vcmi.vcmi;

import android.content.Context;
import android.content.Intent;
import android.app.DownloadManager;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.os.Messenger;
import android.os.VibrationEffect;
import android.os.Vibrator;

import org.libsdl.app.SDL;
import org.libsdl.app.SDLActivity;

import java.io.File;
import java.lang.ref.WeakReference;

import eu.vcmi.vcmi.util.Log;

/**
 * @author F
 */
public class NativeMethods
{
    private static WeakReference<Messenger> serverMessengerRef;

    public NativeMethods()
    {
    }

    public static native void initClassloader();
    public static native void heroesDataUpdate();

    public static void setupMsg(final Messenger msg)
    {
        serverMessengerRef = new WeakReference<>(msg);
    }

    @SuppressWarnings(Const.JNI_METHOD_SUPPRESS)
    public static String dataRoot()
    {
        final Context ctx = SDL.getContext();
        String root = Storage.getVcmiDataDir(ctx).getAbsolutePath();

        Log.i("Accessing data root: " + root);
        return root;
    }

    // this path is visible only to this application; we can store base vcmi configs etc. there
    @SuppressWarnings(Const.JNI_METHOD_SUPPRESS)
    public static String internalDataRoot()
    {
        final Context ctx = SDL.getContext();
        String root = new File(ctx.getFilesDir(), Const.VCMI_DATA_ROOT_FOLDER_NAME).getAbsolutePath();
        Log.i("Accessing internal data root: " + root);
        return root;
    }

    @SuppressWarnings(Const.JNI_METHOD_SUPPRESS)
    public static String nativePath()
    {
        final Context ctx = SDL.getContext();
        Log.i("Accessing ndk path: " + ctx.getApplicationInfo().nativeLibraryDir);
        return ctx.getApplicationInfo().nativeLibraryDir;
    }

    @SuppressWarnings(Const.JNI_METHOD_SUPPRESS)
    public static void showProgress()
    {
        internalProgressDisplay(true);
    }

    @SuppressWarnings(Const.JNI_METHOD_SUPPRESS)
    public static void hideProgress()
    {
        internalProgressDisplay(false);
    }
    
    @SuppressWarnings(Const.JNI_METHOD_SUPPRESS)
    public static void hapticFeedback()
    {
        final Context ctx = SDL.getContext();
        if (Build.VERSION.SDK_INT >= 29) {
            ((Vibrator) ctx.getSystemService(ctx.VIBRATOR_SERVICE)).vibrate(VibrationEffect.createPredefined(VibrationEffect.EFFECT_TICK));
        } else {
            ((Vibrator) ctx.getSystemService(ctx.VIBRATOR_SERVICE)).vibrate(30);
        }
    }

    @SuppressWarnings(Const.JNI_METHOD_SUPPRESS)
    public static long startBackgroundDownload(final String url, final String destinationPath)
    {
        final Context ctx = SDL.getContext();
        ctx.startService(new Intent(ctx, BackgroundDownloadService.class));

        DownloadManager mgr = (DownloadManager) ctx.getSystemService(Context.DOWNLOAD_SERVICE);
        if (mgr == null)
            return -1;

        DownloadManager.Request req = new DownloadManager.Request(Uri.parse(url));
        req.setAllowedOverMetered(true);
        req.setAllowedOverRoaming(true);
        req.setTitle("VCMI download");
        req.setDescription(new File(destinationPath).getName());
        req.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
        req.setDestinationUri(Uri.fromFile(new File(destinationPath)));
        return mgr.enqueue(req);
    }

    @SuppressWarnings(Const.JNI_METHOD_SUPPRESS)
    public static String backgroundDownloadStatus(final long id)
    {
        final Context ctx = SDL.getContext();
        DownloadManager mgr = (DownloadManager) ctx.getSystemService(Context.DOWNLOAD_SERVICE);
        if (mgr == null)
            return "0;0;1;1;Download manager unavailable";

        DownloadManager.Query q = new DownloadManager.Query();
        q.setFilterById(id);
        try (Cursor cursor = mgr.query(q))
        {
            if (cursor == null || !cursor.moveToFirst())
                return "0;0;1;1;Download not found";

            long received = cursor.getLong(cursor.getColumnIndexOrThrow(DownloadManager.COLUMN_BYTES_DOWNLOADED_SO_FAR));
            long total = cursor.getLong(cursor.getColumnIndexOrThrow(DownloadManager.COLUMN_TOTAL_SIZE_BYTES));
            int status = cursor.getInt(cursor.getColumnIndexOrThrow(DownloadManager.COLUMN_STATUS));
            int reason = cursor.getInt(cursor.getColumnIndexOrThrow(DownloadManager.COLUMN_REASON));

            boolean finished = status == DownloadManager.STATUS_SUCCESSFUL || status == DownloadManager.STATUS_FAILED;
            boolean failed = status == DownloadManager.STATUS_FAILED;
            String err = failed ? ("Download failed: " + reason) : "";
            return received + ";" + total + ";" + (finished ? "1" : "0") + ";" + (failed ? "1" : "0") + ";" + err;
        }
    }

    private static void internalProgressDisplay(final boolean show)
    {
        final Context ctx = SDL.getContext();
        if (!(ctx instanceof VcmiSDLActivity))
        {
            return;
        }
        ((SDLActivity) ctx).runOnUiThread(() -> ((VcmiSDLActivity) ctx).displayProgress(show));
    }

    private static Messenger requireServerMessenger()
    {
        Messenger msg = serverMessengerRef.get();
        if (msg == null)
        {
            throw new RuntimeException("Broken server messenger");
        }
        return msg;
    }
}
