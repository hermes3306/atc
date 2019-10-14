drop replication   rep1;
drop replication   rep2;
drop replication   rep3;
drop replication   rep4;
drop replication   rep5;
drop replication   rep6;
drop replication   rep7;
drop replication   rep8;
drop replication   rep9;

create replication rep1
with '10.1.10.241', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep2
with '10.1.10.242', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep3
with '10.1.10.243', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep4
with '10.1.10.244', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep5
with '10.1.10.245', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep6
with '10.1.10.246', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep7
with '10.1.10.247', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep8
with '10.1.10.248', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;

create replication rep9
with '10.1.10.249', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;
