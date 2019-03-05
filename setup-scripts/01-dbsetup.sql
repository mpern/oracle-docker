
alter session set container = ORCLPDB1;

create user localdev identified by localdev;

grant create session to localdev;
grant create table to localdev;
grant create materialized view to localdev;
grant create view to localdev;
grant create synonym to localdev;
grant unlimited tablespace to localdev;
grant "CONNECT" to localdev;
grant "RESOURCE" to localdev;

create or replace directory LOCAL_PUMP_DIR as '/opt/oracle/dump';