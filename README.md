# git-server
Provides a simple git server, using git-daemon, in a Docker image.

See [kineticfire/git-server at Docker Hub](https://hub.docker.com/r/kineticfire/git-server) for the git-server Docker image and additional documentation.


# Table of Contents
1. [Key Capabilities](#key-capabilities)
2. [Remote Backup Script](#remote-backup-script)
3. [License](#license)


# Key Capabilities
Key capabilities of git-server include:
1. Daily automated backup script
2. Does NOT run as root, and configurable UID/GID process owner
3. Host-mounted repositories

Note that a container run from this image does NOT support authentication or encrypted connections, and it is assumed that the container is run on a system that provides those mechanisms such as via ssh.


# Remote Backup Script
The 'backup-node' directory contains a template crontab and shell script for remote daily retrieval of the backups created by the git-server.

- sudo apt-get update
- sudo apt-get install cron
- Create a directory to hold crontab and related scripts:
   - mkdir -p ~/cron/scripts
- Put crontab and the shell script files as follows:
   - cp crontab ~/cron/\<username\>-crontab
   - cp git-backup.sh ~/cron/scripts
- Make the shell script executable
   - chmod +x ~/cron/scripts/git-backup.sh
- Create a backup directory for the git backups, such as:
   - mkdir -p ~/backups/git
- Edit the git-backup.sh script and set the values indicated at the top of the file
   - 'gitSystem'
   - 'remoteBackupDir'
   - 'remoteTempDir'
   - 'localBackupDir'
   - 'maxagedays'
- Edit the crontab file and
   - set the path the git-backup.sh script
   - optionally, adjust the time and frequency of the backup retrieval
- Check if a crontab is loaded.  If so, the crontabs should be merged.  It is recommended to keep a local copy of the crontab file (such as in ~/cron) because it makes it easier to edit and load vs. using the crontab editor.
   - crontab -l
- Load the crontab
   - crontab ~/cron/\<username\>-crontab
- Check that the crontab loaded
   - crontab -l

Note:  To remove the crontab, use crontab -r


# License
- This project is released under [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0)
- git is released under [GNU General Public License version 2](https://opensource.org/licenses/GPL-2.0)
