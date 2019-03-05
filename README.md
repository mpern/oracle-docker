# Oracle Docker (Compose) Template

A quick and easy way to restore an Oracle DB dump for local development

## Prerequisites

You need to build official Oracle docker image for Oracle DB 12.1.0.2 for this
setup, if you haven't done so already.

1. Clone the official [oracle/docker-images][oracle-images] repository
1. Download required files into `OracleDatabase/SingleInstance/dockerfiles/12.1.0.2`

    1. Go to the [Oracle Database 12c Release 1 (12.1.0.2.0) for Linux][oracle-download]
       download page
    1. Download `linuxamd64_12c_database_1of2.zip`
    1. Download `linuxamd64_12c_database_2of2.zip`

1. Build the 12.1.02 Enterprise Edition image

    ```sh
    cd OracleDatabase/SingleInstance/dockerfiles
    ./buildDockerImage.sh -v 12.1.0.2 -e
    ```
> **Docker for Mac / Docker for Windows**\
> Make sure to increase the RAM (at least 8GB) and (if necessary) the disk size of the Docker VM!

## How to use

1. Download this repo as zip
1. Unpack
1. Rename the unpacked folder to something more meaningful, e.g. `project_db`
1. Place your Oracle `expdp` dump file in `./dump`.\
   The file must be named `dump.dmp`.
1. Tweak `docker-compose.yml`

    - make sure that `SOURCE_SCHEMA` and `SOURCE_TABLESPACE` match the schema
      and tablespace of the dump
    - you may want to additionally exclude `GRANT`: `EXCLUDE=USER,GRANT`, if your dump contains
      them

   (If you don't know, ask the DBA that created the dump. Or try to import and 
   check the errors in `./dump/import.log`)
1. *(optional)* Add additional setup files to `setup-scripts` (initial setup 
   supports`*.sql` or `*.sh` files, they are executed in order)
1. ```
   cd project_db
   docker-compose up
   ```
1. Grab a pint of :coffee: and wait until the database setup including dump import is done.

The password for all Oracle system accounts (`SYSTEM`, `SYS`, `PDBADMIN`) is `oracle`

The `db.*` properties for SAP Commerce are:

```properties
db.url=jdbc:oracle:thin:@localhost:1521/ORCLPDB1
db.driver=oracle.jdbc.driver.OracleDriver
db.username=localdev
db.password=localdev
```

> Don't forget to place the `ojdbc*.jar` ([Download here][ojdbc]) in
> `hybris/bin/platform/lib/dbdriver`!

[oracle-images]: https://github.com/oracle/docker-images
[oracle-download]: https://www.oracle.com/technetwork/database/enterprise-edition/downloads/database12c-linux-download-2240591.html
[ojdbc]: https://www.oracle.com/technetwork/database/features/jdbc/jdbc-ucp-122-3110062.html
