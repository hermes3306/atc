exec gather_database_stats(1);
exec set_column_stats( 'sys', 'lineitem', 'l_orderkey', null, 45000000 );
exec set_column_stats( 'sys', 'lineitem', 'l_partkey' , null,  6000000 );
exec set_column_stats( 'sys', 'lineitem', 'l_suppkey' , null,   300000 );
exec set_column_stats( 'sys', 'orders'  , 'o_orderkey', null, 45000000 );
exec set_column_stats( 'sys', 'orders'  , 'o_custkey' , null,  3000000 );
