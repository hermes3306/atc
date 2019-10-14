drop replication   rep4;
create replication rep4 
with '10.1.10.240', 20400 
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;
