exec gather_database_stats(1);
exec set_column_stats( 'sys', 'lineitem', 'l_orderkey', null, 1500000 );
exec set_column_stats( 'sys', 'lineitem', 'l_partkey' , null,  200000 );
exec set_column_stats( 'sys', 'lineitem', 'l_suppkey' , null,   10000 );
exec set_column_stats( 'sys', 'orders'  , 'o_orderkey', null, 1500000 );
exec set_column_stats( 'sys', 'orders'  , 'o_custkey' , null,  100000 );
