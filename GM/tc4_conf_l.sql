delete from test;
exec dbms_shard.unset_shard_table ('sys','TEST');

exec dbms_shard.unset_node('dn1');
exec dbms_shard.unset_node('dn2');
exec dbms_shard.unset_node('dn3');
exec dbms_shard.unset_node('dn4');


exec dbms_shard.set_node('dn1','dn1',20401);
exec dbms_shard.set_node('dn2','dn2',20402);
exec dbms_shard.set_node('dn3','dn3',20403);
exec dbms_shard.set_node('dn4','dn4',20404);

alter session set shard linker=on;

exec dbms_shard.set_shard_table ('sys','TEST','l','K02','dn1');

exec dbms_shard.set_shard_list ('sys','TEST',1, 'dn1');
exec dbms_shard.set_shard_list ('sys','TEST',2, 'dn2');
exec dbms_shard.set_shard_list ('sys','TEST',3, 'dn3');
exec dbms_shard.set_shard_list ('sys','TEST',4, 'dn4');



