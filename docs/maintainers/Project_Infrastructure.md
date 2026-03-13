# Project Infrastructure

## What's to improve

1. Encourage Tow to transfer VCMI.eu to GANDI so it's can be also renewed without access.
2. Centralized way to post news about game updates to all social media.
3. Verify VCMI.eu domain name expiration date with Tow
4. Verify VCMI.download domain name expiration date with SXX
5. Verify Google Apps (G Suite) status with Tow
6. Restore firewall which for some reason is disabled on DO
7. Migrate remaining services from `vcmi-second` droplet

## Services and accounts

### Infrastructure

| Service | Details | Owner/Admin Access | Notes |
|---------|---------|-------------------|-------|
| [GitHub](https://github.com/vcmi/) | Code hosting, bug tracker, pull requests, website hosting | Admin: Tow, AVS, Ivan, Warmonger, SXX | - |
| [VCMI.eu domain name](https://vcmi.eu) | Main domain for services | Owner: Tow | Renewal date **unknown** |
| [VCMI.download domain name](https://vcmi.download) | Secondary domain name for downloads | Owner: SXX | Paid until **November 2026**. Registered on GANDI; **can be renewed by anyone without account access** |
| [DigitalOcean](https://cloud.digitalocean.com/) | Hosting sponsor for all our self-hosted services | Admin: SXX, Warmonger, Ivan; User: AVS, Tow | - |
| [CloudFlare](https://www.cloudflare.com/a/overview) | DNS & CDN for our web services | Admin: SXX, Ivan | All our web services are behind CloudFlare and use Cloudflare SSL certificates |
| [Weblate](https://hosted.weblate.org/projects/vcmi/) | Game translations | Admin: Ivan | Hosts translations for VCMI itself (not including mods & website). Uses free "Gratis" plan |
| [Google Play Console](https://play.google.com/apps/publish/) | VCMI Android App | Owner: SXX; Admin: Warmonger, AVS, Ivan; Release Manager: Fay | - |
| [Google Apps (G Suite)](https://admin.google.com/) | Email for vcmi.eu domain | Admin: Tow, SXX | Limited to 5 users; 500 emails/day limit per account. Includes: admin email (service registration), "noreply" (Wiki/Bug Tracker), "forum" (Forums authentication). **Likely dead. Verify with Tow** |
| [Launchpad PPA](https://launchpad.net/~vcmi) | Ubuntu package repository | Member: AVS; Admin: Ivan, SXX | Contains daily builds and latest releases PPA's for Ubuntu |
| [Sonar Cloud](https://sonarcloud.io/project/overview?id=vcmi_vcmi) | Code analysis | Shares credentials with Github | Integrated into Github pull requests |
| [Snapcraft Dashboard](https://dashboard.snapcraft.io/) | Snap package distribution | Admin: SXX | Abandoned in favor of Flatpaks and PPA |
| [Coverity Scan](https://scan.coverity.com/projects/vcmi) | Code analysis | Admin: SXX, Warmonger, AVS | Abandoned in favor of Sonar Cloud |
| [OpenHub](https://www.openhub.net/p/VCMI) | Code statistics | Admin: Tow | - |
| [Docker Hub](https://hub.docker.com/u/vcmi/) | Container registry | Admin: SXX | Abandoned and never used? |
| [GitLab](https://gitlab.com/vcmi/) | Code repository | Admin: SXX | Reserve account, not used |
| [BitBucket](https://bitbucket.org/vcmi/) | Code repository | Admin: SXX | Reserve account, not used |

When possible at least two of active core developers must have access to them in case of emergency.

#### Communities with page managed by VCMI Team

| Service Name | Owner | Administrators | Notes |
|--------------|-------|----------------|-------|
| [Discord](https://discord.com/) | dydzio | SXX, Warmonger, Ivan... | Main communication platform |
| [Facebook page](https://www.facebook.com/VCMIOfficial) | — | SXX, Warmonger | Active |
| [Reddit](https://reddit.com/r/vcmi/) | — | SXX | Abandoned in favor of general H3 subreddits |
| [Twitter account](https://twitter.com/VCMIOfficial) | — | SXX | Abandoned, User access via TweetDeck |
| [VK / VKontakte page](https://vk.com/VCMIOfficial) | SXX | AVS | Abandoned |
| [Steam group](https://steamcommunity.com/groups/VCMI) | SXX | Dydzio | Abandoned |
| [ModDB entry](http://www.moddb.com/engines/vcmi) | — | SXX | Abandoned |
| [Slack team](https://h3vcmi.slack.com/) | vmarkovtsev | SXX, Warmonger, AVS... | Abandoned in favor of Discord |
| [Trello team](https://trello.com/vcmi/) | — | SXX | Abandoned |

#### Heroes 3 communities with VCMI Team presence

| Service Name | Team members on this platform | Notes |
|--------------|-------------------------------|-------|
| [VCMI thread on Heroes Community](http://heroescommunity.com/viewthread.php3?TID=30659&pagenumber=1) | Warmonger, Ivan, dydzio... | Very low player activity |
| [Heroes 3 subreddit](https://www.reddit.com/r/heroes3/) | Ivan, dydzio... | VCMI-related questions are rather common |
| [HoMM subreddit](https://www.reddit.com/r/HoMM/) | Ivan, dydzio... | Way less active than Heroes 3 subreddit, but sometimes posts about VCMI do appear |

## Project Servers Configuration

This section dedicated to explain specific configurations of our servers for anyone who might need to improve it in future.

### Droplet configuration

All droplets can only be accessed using ssh login with public key. Currently access is granted to:
- Ivan Savenko
- Alexvins
- Warmonger
- Tow
- SXX

| Droplet | Specifications | Services |
|---------|----------------|----------|
| `vcmi-artifactory` | 4 Gb / 2 CPU / 80 Gb / $24 | [Conan Artifactory server](https://artifactory.vcmi.eu/) (WIP) |
| `vcmi-forum` | 2 Gb / 1 CPU / 25 Gb / $12 (+20%) |[Discourse forum](https://forum.vcmi.eu/) |
| `vcmi-second` | 1 Gb / 1 CPU / 20 Gb + 100 Gb / $6 + $10 | Multiplayer lobby (lobby.vcmi.eu or beholder.vcmi.eu - deprecated). Floating IP: 67.207.75.182, Builds uploading from Github, [Build download page](http://download.vcmi.eu/), [Legacy download page](https://builds.vcmi.download/) |
| `vcmi-web` | 512 Mb / 1 CPU / 10 Gb / $4 (+20%) | Contains nginx server for redirecting [old bug tracker](https://bugs.vcmi.eu/), [old wiki](https://wiki.vcmi.eu/), and [old slack invite page](https://slack.vcmi.eu/) |

Notes:
- Droplets with production services have backups enabled (+20% costs)
- In addition to droplets, we have separate 100 Gb volume for builds ($10 / month)
- There is snapshot for old `vcmi-main` droplet, preserved in case if we need to retrieve some data from it ($1.5 / month)

To keep everything secure we should always keep binary downloads separate from any web services.

### Rules to stick to

- SSH authentication by public key only.
- Incoming connections to all ports except SSH (22) must be blocked.
- Exception for HTTP(S) connection on ports 80 / 443 from [CloudFlare IP Ranges](https://www.cloudflare.com/ips/).
- No one except core developers should ever know real server IPs.
- Droplet hostname should never be valid host. Otherwise it's exposed in [reverse DNS](https://en.wikipedia.org/wiki/Reverse_DNS).
- If some non-web service need to listen for external connections then read below.

### Our publicly-facing server

We only expose reserve IP that can be detached from droplet in case of emergency using DO control panel. This also allow us to easily move public services to dedicated droplet in future.

- Address: beholder.vcmi.eu (67.207.75.182)
- Port 22 serve SFTP for file uploads as well as CI artifacts uploads.

If new services added firewall rules can be adjusted in [DO control panel](https://cloud.digitalocean.com/networking/firewalls).

## Domain names

| Domain | Content | Hosted on | Notes |
|--------|---------|-----------|-------|
| [vcmi.eu](https://vcmi.eu) | Main page redirect | CNAME | No content, redirects to [real main page](https://vcmi.github.io/) |
| [download.vcmi.eu](https://download.vcmi.eu) | Public downloads & daily builds | `vcmi-second` | - |
| [beholder.vcmi.eu](https://beholder.vcmi.eu) | Multiplayer lobby | `vcmi-second` | No http services. Used for VCMI 1.7 lobby and older. Also handles build uploads from Github. Deprecated in favor of lobby and uploads |
| [lobby.vcmi.eu](https://lobby.vcmi.eu) | Multiplayer lobby | `vcmi-second` | No http services |
| [forum.vcmi.eu](https://forum.vcmi.eu) | Discourse forum | `vcmi-forum` | - |
| [bugs.vcmi.eu](https://bugs.vcmi.eu) | Bug tracker | `vcmi-web` | Redirects to [Github Issues](https://github.com/vcmi/vcmi/issues) |
| [slack.vcmi.eu](https://slack.vcmi.eu) | Slack invite page | `vcmi-web` | Redirects to [main page](https://vcmi.eu/) |
| [wiki.vcmi.eu](https://wiki.vcmi.eu) | Wiki | `vcmi-web` | Redirects to [main page](https://vcmi.eu/) |
| [vcmi.download](https://vcmi.download) | Main page redirect | CNAME | No content, redirects to [main page](https://vcmi.eu/) |
| [builds.vcmi.download](https://builds.vcmi.download) | Public downloads | `vcmi-second` | Same content as main download server. Known bug: excessive caching. Potentially deprecated in favor of main domain |
| [dependencies.vcmi.download](https://dependencies.vcmi.download) | — | — | Not configured |
| [mods.vcmi.download](https://mods.vcmi.download) | — | — | Not configured |

## Self-hosted services

Currenly we have following services in production:

- Discourse
- Multiplayer lobby
- Downloads & daily builds

Potential addition for the future:

- Conan Artifactory
- Self-hosted Weblate, to bypass Libre tier restrictions on our Weblate hosted by upstream team
- Crash reporter tool, such as [GlitchTip](https://glitchtip.com/)

### Discourse

RAM requirements: ~1.5 GB.
CPU requirements: 1 core
SSD requirements: ~20 GB. May be more over time

Accessible as [forum.vcmi.eu](https://forum.vcmi.eu/)

Admin access:
- Ivan Savenko
- AVS
- SXX
- Warmonger

### Configuration

- Located at `/var/discourse`.
- Configuration file is at `/var/discourse/containers/app.yml`
- For administration typical approach is `cd /var/discourse; ./launcher enter app`. However most commands are also available in web UI
- To apply configuration changes, `cd /var/discourse; ./launcher rebuild app`. WARNING: this will also perform update of Discourse itself!

### Setup

References:
- [official docs](https://github.com/discourse/discourse/blob/main/docs/INSTALL-cloud.md):
- [nginx multi-server configuration](https://meta.discourse.org/t/run-other-websites-on-the-same-machine-as-discourse/17247)

```sh
wget -qO- https://raw.githubusercontent.com/discourse/discourse_docker/main/install-discourse | sudo bash
```

Configure Discourse to run through nginx outside of container, to allow multiple sites to be hosted on same server.

1. Install nginx
2. Edit configuration at `/var/discourse/containers/app.yml`:
```
  - "templates/postgres.template.yml"
  - "templates/redis.template.yml"
  - "templates/web.template.yml"
  - "templates/web.ratelimited.template.yml"
  - "templates/web.socketed.template.yml"  # <-- Added
#   - "templates/web.ssl.template.yml" # remove - https will be handled by outer nginx
#   - "templates/web.letsencrypt.ssl.template.yml" # remove -- https will be handled by outer nginx
# expose: # comment out entire section by putting a # in front of each line
# - "80:80"   # http
# - "443:443" # https  
```
3. Configure nginx server
4. Rebuild app and restart nginx


Approximate order of commands:

```
cd /var/discourse
apt install nginx
nano containers/app.yml

cd /etc/nginx/sites-available
cp default forum.vcmi.eu
cd ../sites-enabled
ln -s ../sites-available/forum.vcmi.eu

./launcher rebuild app
sudo service nginx reload
```

### Upgrade

```
cd /var/discourse
./launcher rebuild app
```

Alternatively can be done in UI, but untested

#### Migration

When setting up Discourse, it needs to be already located on target domain name, so it might be a good idea to do operations in following order:

- create backup on old server (or pick latest weekly backup)
- switch domain name to new IP & wait for DNS to propagate
- ensure that ports 80 and 443 are open on new server
- setup Discourse on new server
- restore backup either in web interface or in console on new server
- adjust or migrate configuration file from old server to new one

### Multiplayer lobby

RAM requirements: ~1 GB (can be potentially reduced if we were to track down all un-indexed sqlite queries)
CPU requirements: 1 core (preferrably dedicated to ensure low latency)
SSD requirements: up to 4 Gb (depending on log and database size over time)

Exposed to public as `beholder.vcmi.eu:3031` or `lobby.vcmi.eu:3031` 

- Start: `cd /home/vcmilobby/build/bin && ./vcmilobby &`
- Stop: `killall -9 vcmilobby`
- Examine database (can be done live): `sqlite3 ~/.local/share/vcmi/vcmiLobby.db`
- Examine log file: `nano ~/.cache/vcmi/VCMI_Lobby_log.txt`

### Setup

```
git clone https://github.com/vcmi/vcmi.git
mkdir build
cmake -DENABLE_EDITOR=OFF -DENABLE_CLIENT=OFF -DENABLE_SERVER=OFF -DENABLE_LAUNCHER=OFF -DENABLE_TEST=OFF -DENABLE_LOBBY=ON -DENABLE_MINIMAL_LIB=ON -DENABLE_PCH=OFF -DENABLE_STATIC_LIBS=ON ../vcmi`
make
```

Note: rebuild may take up to 15 minutes. You might want to rebuild first, without shutting down server and then - quickly restart server
Note: server has configured swap file specifically to allow building vcmilobby locally. System memory usage was slightly over 1 Gb during build.

### Upgrade

```
cd /home/vcmilobby/vcmi && git pull --ff-only
cd /home/vcmilobby/build && make
killall -9 vcmilobby
cd /home/vcmilobby/build/bin && ./vcmilobby &
```

#### Migration

- setup binary on new server
- stop old server
- transfer database at `~/.local/share/vcmi/vcmiLobby.db` to new server
- adjust domain name to point to new server
- start new server

### Builds downloads server

RAM requirements: non-existing
CPU requirements: non-existing
SSD requirements: 100 GB, ideally - 200 GB. Can be located on a separate volume
