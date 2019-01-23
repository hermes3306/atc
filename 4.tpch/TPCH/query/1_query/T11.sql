-- using 123165034 as a seed to the RNG
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;




SELECT
	P_BRAND,
	P_TYPE,
	P_SIZE,
	COUNT(DISTINCT PS_SUPPKEY) AS SUPPLIER_CNT
FROM
	PARTSUPP,
	PART
WHERE
	P_PARTKEY = PS_PARTKEY
	AND P_BRAND <> 'Brand#42'
	AND P_TYPE NOT LIKE 'LARGE BRUSHED%'
	AND P_SIZE IN (23, 13, 25, 15, 28, 43, 42, 46)
	AND PS_SUPPKEY NOT IN (
		SELECT
			S_SUPPKEY
		FROM
			SUPPLIER
		WHERE
			S_COMMENT LIKE '%CUSTOMER%COMPLAINTS%'
	)
GROUP BY
	P_BRAND,
	P_TYPE,
	P_SIZE
ORDER BY
	SUPPLIER_CNT DESC,
	P_BRAND,
	P_TYPE,
	P_SIZE;

set timing off;
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
