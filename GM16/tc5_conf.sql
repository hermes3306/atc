delete from test;
exec dbms_shard.unset_shard_table ('sys','TEST');

exec dbms_shard.unset_node('dn1');
exec dbms_shard.unset_node('dn2');
exec dbms_shard.unset_node('dn3');
exec dbms_shard.unset_node('dn4');

exec dbms_shard.set_node('dn1','127.0.0.1',20401);
exec dbms_shard.set_node('dn2','127.0.0.1',20402);
exec dbms_shard.set_node('dn3','127.0.0.1',20403);
exec dbms_shard.set_node('dn4','127.0.0.1',20404);

alter session set shard linker=on;

exec dbms_shard.set_shard_table ('sys','TEST','r','K01');

exec dbms_shard.set_shard_range ('sys','TEST', 25000, 'dn1');
exec dbms_shard.set_shard_range ('sys','TEST', 50000, 'dn2');
exec dbms_shard.set_shard_range ('sys','TEST', 75000, 'dn3');
exec dbms_shard.set_shard_range ('sys','TEST', 100000, 'dn4');


exec dbms_shard.check_data('sys','test');
