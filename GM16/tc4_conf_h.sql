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


exec dbms_shard.set_node('dn1','dn1',20401);
exec dbms_shard.set_node('dn2','dn2',20402);
exec dbms_shard.set_node('dn3','dn3',20403);
exec dbms_shard.set_node('dn4','dn4',20404);
exec dbms_shard.set_node('dn5','dn5',20405);
exec dbms_shard.set_node('dn6','dn6',20406);
exec dbms_shard.set_node('dn7','dn7',20407);
exec dbms_shard.set_node('dn8','dn8',20408);
exec dbms_shard.set_node('dn9','dn9',20409);
exec dbms_shard.set_node('dn10','dn10',20410);
exec dbms_shard.set_node('dn11','dn11',20411);
exec dbms_shard.set_node('dn12','dn12',20412);
exec dbms_shard.set_node('dn13','dn13',20413);
exec dbms_shard.set_node('dn14','dn14',20414);
exec dbms_shard.set_node('dn15','dn15',20415);
exec dbms_shard.set_node('dn16','dn16',20416);

alter session set shard linker=on;

exec dbms_shard.set_shard_table ('sys','TEST','h','K01');

exec dbms_shard.set_shard_hash ('sys','TEST', 50,  'dn1');
exec dbms_shard.set_shard_hash ('sys','TEST', 100,  'dn2');
exec dbms_shard.set_shard_hash ('sys','TEST', 150,  'dn3');
exec dbms_shard.set_shard_hash ('sys','TEST', 200, 'dn4');
exec dbms_shard.set_shard_hash ('sys','TEST', 250,  'dn5');
exec dbms_shard.set_shard_hash ('sys','TEST', 300,  'dn6');
exec dbms_shard.set_shard_hash ('sys','TEST', 350,  'dn7');
exec dbms_shard.set_shard_hash ('sys','TEST', 400,  'dn8');
exec dbms_shard.set_shard_hash ('sys','TEST', 500,  'dn9');
exec dbms_shard.set_shard_hash ('sys','TEST', 540,  'dn10');
exec dbms_shard.set_shard_hash ('sys','TEST', 600, 'dn11');
exec dbms_shard.set_shard_hash ('sys','TEST', 650,  'dn12');
exec dbms_shard.set_shard_hash ('sys','TEST', 700,  'dn13');
exec dbms_shard.set_shard_hash ('sys','TEST', 750, 'dn14');
exec dbms_shard.set_shard_hash ('sys','TEST', 800,  'dn15');
exec dbms_shard.set_shard_hash ('sys','TEST', 1000,  'dn16');

