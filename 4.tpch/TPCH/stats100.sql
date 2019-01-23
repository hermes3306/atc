exec gather_database_stats(1);
exec set_column_stats( 'sys', 'lineitem', 'l_orderkey', null, 150000000 );
exec set_column_stats( 'sys', 'lineitem', 'l_partkey' , null,  20000000 );
exec set_column_stats( 'sys', 'lineitem', 'l_suppkey' , null,   1000000 );
exec set_column_stats( 'sys', 'orders'  , 'o_orderkey', null, 150000000 );
exec set_column_stats( 'sys', 'orders'  , 'o_custkey' , null,   9999832 );
