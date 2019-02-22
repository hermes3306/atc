delete from test;

exec dbms_shard.unset_shard_table ('sys','TEST');

exec dbms_shard.unset_node('dn1');
exec dbms_shard.unset_node('dn2');
exec dbms_shard.unset_node('dn3');
exec dbms_shard.unset_node('dn4');
exec dbms_shard.unset_node('dn5');
exec dbms_shard.unset_node('dn6');
exec dbms_shard.unset_node('dn7');
exec dbms_shard.unset_node('dn8');
exec dbms_shard.unset_node('dn9');
exec dbms_shard.unset_node('dn10');
exec dbms_shard.unset_node('dn11');
exec dbms_shard.unset_node('dn12');
exec dbms_shard.unset_node('dn13');
exec dbms_shard.unset_node('dn14');
exec dbms_shard.unset_node('dn15');
exec dbms_shard.unset_node('dn16');


exec dbms_shard.set_node('dn1','dn1',20401);
exec dbms_shard.set_node('dn2','dn2',20402);
exec dbms_shard.set_node('dn3','dn3',20403);
exec dbms_shard.set_node('dn4','dn4',20404);
exec dbms_shard.set_node('dn5','dn5',20405);
exec dbms_shard.set_node('dn6','dn6',20406);
exec dbms_shard.set_node('dn7','dn7',20407);
exec dbms_shard.set_node('dn8','dn8',20408);


alter session set shard linker=on;

exec dbms_shard.set_shard_table ('sys','TEST','h','K01');


exec dbms_shard.set_shard_hash ('sys','TEST', 125, 'dn1');
exec dbms_shard.set_shard_hash ('sys','TEST', 250, 'dn2');
exec dbms_shard.set_shard_hash ('sys','TEST', 375, 'dn3');
exec dbms_shard.set_shard_hash ('sys','TEST', 500, 'dn4');
exec dbms_shard.set_shard_hash ('sys','TEST', 625, 'dn5');
exec dbms_shard.set_shard_hash ('sys','TEST', 750, 'dn6');
exec dbms_shard.set_shard_hash ('sys','TEST', 875, 'dn7');
exec dbms_shard.set_shard_hash ('sys','TEST', 1000, 'dn8');




