drop replication   rep1;
drop replication   rep2;
drop replication   rep3;
drop replication   rep4;
drop replication   rep5;
drop replication   rep6;
drop replication   rep7;
drop replication   rep8;
drop replication   rep9;
drop replication   rep10;

create replication rep1
with '10.1.10.101', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep2
with '10.1.10.102', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep3
with '10.1.10.103', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep4
with '10.1.10.104', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep5
with '10.1.10.105', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep6
with '10.1.10.106', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep7
with '10.1.10.107', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep8
with '10.1.10.108', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep9
with '10.1.10.109', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep10
with '10.1.10.200', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;
