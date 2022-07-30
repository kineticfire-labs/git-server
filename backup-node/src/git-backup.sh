#!/bin/bash
set -e


gitSystem=<IP, domain name, or name in ssh/config>
remoteBackupDir=<directory on remote system that holdes the backup, such as /some/path/git/data>
remoteTempDir=<temp directory on remote system>
localBackupDir=<local backup directory, such as /some/path/backups/git>
maxagedays=<max age in days to keep backups, such as 30>



dt=$(date +%F)

repoDumpFileName=$dt-all-git-repos.tar.gz

# copy backup file from remote original directory to remote temp directory
ssh $gitSystem "sudo cp $remoteBackupDir/$repoDumpFileName $remoteTempDir"

# copy backup file from remote temp directory to local backup directory
scp $gitSystem:$remoteTempDir/$repoDumpFileName $localBackupDir

# delete backup file in the remote temp directory
ssh $gitSystem "rm $remoteTempDir/$repoDumpFileName"

# note that the original backup file in the remote directory is retained


find /$backupdir -type f -iname '*-all-git-repos.tar.gz' -mtime +$maxagedays -exec rm -f {} \;
