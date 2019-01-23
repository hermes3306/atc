exec gather_database_stats(1);

-- for setting v$dbms_stats
exec set_system_stats('SREAD_TIME', 87.7022379602905);
exec set_system_stats('MREAD_TIME', 17.2507660007398);
exec set_system_stats('MREAD_PAGE_COUNT', 128);
exec set_system_stats('HASH_TIME', 0.034018);
exec set_system_stats('COMPARE_TIME', 0.005818);
exec set_system_stats('STORE_TIME', 0.0512);
