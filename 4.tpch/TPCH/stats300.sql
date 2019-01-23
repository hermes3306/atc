exec gather_database_stats(1);
exec set_column_stats( 'sys', 'lineitem', 'l_orderkey', null, 450000000 );
exec set_column_stats( 'sys', 'lineitem', 'l_partkey' , null,  60000000 );
exec set_column_stats( 'sys', 'lineitem', 'l_suppkey' , null,   3000000 );
exec set_column_stats( 'sys', 'orders'  , 'o_orderkey', null, 450000000 );
exec set_column_stats( 'sys', 'orders'  , 'o_custkey' , null,  30000000 );
