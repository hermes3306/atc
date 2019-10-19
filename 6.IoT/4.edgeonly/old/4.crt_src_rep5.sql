drop replication   rep5;
create replication rep5 
with '10.1.10.240', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;
