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

exec dbms_shard.set_shard_table ('sys','TEST','r','K01');

exec dbms_shard.set_shard_range ('sys','TEST', 6000, 'dn1');
exec dbms_shard.set_shard_range ('sys','TEST', 12000, 'dn2');
exec dbms_shard.set_shard_range ('sys','TEST', 18000, 'dn3');
exec dbms_shard.set_shard_range ('sys','TEST', 1240000, 'dn4');


