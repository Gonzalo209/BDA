connect sys/system2 as sysdba
create table gonzalo09.t01_session_data (
id number,
sid number,
logon_time date,
username varchar2(10),
status varchar2(20),
server varchar2(20),
osuser varchar2(20),
machine varchar2(80),
type varchar2(20),
process number,
port number
);

alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';

insert into gonzalo09.t01_session_data values(
1,
(select sid from v$session where osuser='gchavez')
(select logon_time from v$session where osuser='gchavez'),
(select username from v$session where osuser='gchavez'),
(select status from v$session where osuser='gchavez'),
(select server from v$session where osuser='gchavez'),
(select osuser from v$session where osuser='gchavez'),
(select machine from v$session where osuser='gchavez'),
(select type from v$session where osuser='gchavez'),
(select process from v$session where osuser='gchavez'),
(select port from v$session where osuser='gchavez')
);

commit;




