drop replication   rep9;
create replication rep9 
with '10.1.10.240', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;
