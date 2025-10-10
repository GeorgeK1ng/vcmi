package eu.vcmi.vcmi;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.DocumentsContract;

import androidx.annotation.Nullable;

import java.io.File;

import eu.vcmi.vcmi.VcmiSDLActivity;

import org.libsdl.app.SDL;

/**
 * @author F
 */
public class ActivityLauncher extends org.qtproject.qt5.android.bindings.QtActivity
{
    private static final int PICK_EXTERNAL_VCMI_DATA_TO_COPY = 1;

    public boolean justLaunched = true;

    @Override
    public void onCreate(@Nullable final Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        justLaunched = savedInstanceState == null;
        SDL.setContext(this);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent resultData)
    {
        if (requestCode == PICK_EXTERNAL_VCMI_DATA_TO_COPY && resultCode == Activity.RESULT_OK)
        {
            if (resultData != null)
            {
                final Uri treeUri = resultData.getData();
                if (treeUri != null)
                {
                    // keep read/write permission to the selected folder (best-effort)
                    final int flags = resultData.getFlags()
                            & (Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
                    try
                    {
                        getContentResolver().takePersistableUriPermission(
                                treeUri,
                                flags | Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_GRANT_WRITE_URI_PERMISSION
                        );
                    }
                    catch (SecurityException ignore)
                    {
                        // some document providers may not support persistable permissions; continue anyway
                    }

                    // hand off to C++: FirstLaunchView::copyHeroesData(QString)
                    NativeMethods.copyHeroesData(treeUri.toString());
                }
            }
            return;
        }

        super.onActivityResult(requestCode, resultCode, resultData);
    }

    public void copyHeroesData()
    {
        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT_TREE);
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION
                | Intent.FLAG_GRANT_WRITE_URI_PERMISSION
                | Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION);

        intent.putExtra(DocumentsContract.EXTRA_INITIAL_URI,
                Uri.fromFile(new File(Environment.getExternalStorageDirectory(), "vcmi-data"))
        );

        startActivityForResult(intent, PICK_EXTERNAL_VCMI_DATA_TO_COPY);
    }

    public void onLaunchGameBtnPressed()
    {
        startActivity(new Intent(ActivityLauncher.this, VcmiSDLActivity.class));
    }
}
