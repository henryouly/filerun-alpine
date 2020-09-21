#!/bin/sh

set -e

WWW_ROOT="/usr/share/nginx/html"

# Install FileRun on first run
if [ ! -e ${WWW_ROOT}/index.php ];  then
	echo "[FileRun fresh install]"
	unzip /srv/filerun.zip -d ${WWW_ROOT}/
	cp /srv/autoconfig.php ${WWW_ROOT}/system/data/
	chmod -R 777 ${WWW_ROOT}/system/data/temp
fi

exit 0
