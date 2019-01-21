drop replication   rep7;
create replication rep7 
with '10.1.10.201', 20400
from smssuser.tbl_sm_data to smssuser.tbl_sm_data;
