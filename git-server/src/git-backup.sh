#!/bin/ash
set -e

# the 'bin/ash' and NOT with a 'b' for 'bash' is correct!


reposdir="/srv/git"
backupdir="/data"
maxagedays=5



dt=$(date +%F)


mkdir $backupdir/$dt-all-git-repos

cd $reposdir


find $reposdir -mindepth 1 -maxdepth 1 -type d | while read dirname; do

    if [ -d "$dirname" ]; then

        #shopt -s extglob          # enable +(...) glob syntax
        result=${dirname%%+(/)}    # trim however many trailing slashes exist
        result=${result##*/}       # remove everything before the last / that still remains
        result=${result:-/}        # correct for dirname=/ case

        tar -cvz -f $backupdir/$dt-all-git-repos/$result-git-repo-$dt.tar.gz $result
    fi
done


cd $backupdir
tar -cvz -f $dt-all-git-repos.tar.gz $dt-all-git-repos
rm -rf $dt-all-git-repos


find /$backupdir -type f -iname '*-all-git-repos.tar.gz' -mtime +$maxagedays -exec rm -f {} \;
