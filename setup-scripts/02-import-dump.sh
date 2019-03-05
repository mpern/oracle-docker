#!/bin/bash

# https://stackoverflow.com/questions/9261979/disable-decrease-the-generation-of-archived-redolog-files-while-importing

EXCLUDE_CMD=
SCHEMA_REMAP=
TABLESPACE_REMAP=

if [ -n "$EXCLUDE" ]; then
    EXCLUDE_CMD="EXCLUDE=$EXCLUDE"
fi

if [ -n "$SOURCE_SCHEMA" ]; then
    SCHEMA_REMAP="REMAP_SCHEMA=$SOURCE_SCHEMA:localdev"
fi

if [ -n "$SOURCE_TABLESPACE" ]; then
    TABLESPACE_REMAP="REMAP_TABLESPACE=$SOURCE_TABLESPACE:users"
fi

impdp PDBADMIN/oracle@ORCLPDB1 \
FULL=y \
DIRECTORY=LOCAL_PUMP_DIR \
DUMPFILE=dump.dmp \
TABLE_EXISTS_ACTION=replace \
TRANSFORM=disable_archive_logging:Y \
"$EXCLUDE_CMD" \
"$SCHEMA_REMAP" \
"$TABLESPACE_REMAP"
