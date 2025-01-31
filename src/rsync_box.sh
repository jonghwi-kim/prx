# Do not run this file directly.
# Must be used in prx python script.
SERVER=$1
WORKDIR=$2

SOURCE=$3
DEST=$4
DRYRUN=$5
REVERSE=$6

RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
PINK='\033[0;35m'


# BACKUPDIR=backups/$(date +%Y%m%d%H%M%S)
# echo "${RED}[rsync]${NC} SERVER: ${GREEN}${SERVER}${NC}"
# echo "${RED}[rsync]${NC} WORKDIR: ${GREEN}${WORKDIR}${NC}"

# check dryrun flag
# if [ "$DRYRUN" = "--dry-run" ]; then
#     echo "${RED}[rsync]${NC} ${RED}dry-run${NC}"
# fi

# local to remote
echo "${RED}[rsync]${NC} sync ${PINK}${SOURCE}${NC} to ${GREEN}$SERVER:$WORKDIR/${DEST}/${SOURCE}${NC}"
# echo "${RED}[rsync]${NC} backup directory: ${GREEN}${BACKUPDIR}${NC}"
# mkdir -p $BACKUPDIR
echo "${RED}[rsync]${NC} rsync -azvP $DRYRUN $SOURCE $SERVER:$WORKDIR/$DEST"
rsync -azvP $DRYRUN $SOURCE $SERVER:$WORKDIR/$DEST

# check if reverse sync is needed
if [ "$REVERSE" = "--reverse" ]; then
    echo "${RED}[rsync]${NC} ${PINK}Reverse sync...${NC}"
    # to avoid creating a nested directory structure specify the destination directory without a trailing slash.
    # e.g. rsync -azvP $DRYRUN $SERVER:$WORKDIR/${DEST}${SOURCE}/ ${SOURCE}
    echo "${RED}[rsync]${NC} rsync -azvP $DRYRUN $SERVER:$WORKDIR/${DEST}${SOURCE}/ ${SOURCE}" 
    rsync -azvP $DRYRUN $SERVER:$WORKDIR/${DEST}${SOURCE}/ ${SOURCE}
fi


if [ "$DRYRUN" = "--dry-run" ]; then
    echo "${RED}[rsync]${NC} Dry run completed. No files were copied."  
else
    echo "${RED}[rsync]${NC} completed."
fi