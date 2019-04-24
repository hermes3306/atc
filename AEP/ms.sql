set linesize 1024
set colsize 30

SELECT decode(type, 0, 'MEMORY_DICTIONARY',
 1, 'MEMORY_SYS_DATA',
 2, 'MEMORY_USER_DATA',
 8, 'VOLATILE_USER_DATA') TBS_TYPE,
 name TBS_NAME,
 decode(maxsize, 140737488322560, '', round(maxsize/1024/1024,2)) 'MAX(M)',
 round(allocated_page_count * page_size / 1024 / 1024, 2) 'TOTAL(M)',
 round(nvl(m.alloc_page_count-m.free_page_count,total_page_count)*page_size/1024/1024,2)
'ALLOC(M)',
 mt.used 'USED(M)',
 decode(maxsize, 140737488322560, round((m.alloc_page_count-m.free_page_count)*page_size/
mem_max_db_size*100, 2),
 decode(maxsize, 0, '-', round((m.alloc_page_count-m.free_page_count)*page_size/maxsize*100,
2))) 'USAGE(%)',
 round(mt.used / round(allocated_page_count * page_size / 1024 / 1024, 2)*100,2)
'TOTAL_USAGE(%)'
FROM v$database d, v$tablespaces t, v$mem_tablespaces m,
( SELECT tablespace_id, round(sum((fixed_used_mem + var_used_mem))/(1024*1024),3) used
 FROM v$memtbl_info
GROUP by tablespace_id) mt
WHERE t.id = m.space_id
 and id = mt.tablespace_id
;
