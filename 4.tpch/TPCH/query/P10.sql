-- using 123165033 as a seed to the RNG
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;




SELECT
	C_COUNT,
	COUNT(*) AS CUSTDIST
FROM
	(
		SELECT
			C_CUSTKEY,
			COUNT(O_ORDERKEY) AS C_COUNT
		FROM
			CUSTOMER LEFT OUTER JOIN ORDERS ON
				C_CUSTKEY = O_CUSTKEY
				AND O_COMMENT NOT LIKE '%special%packages%'
		GROUP BY
			C_CUSTKEY
	) C_ORDERS 
GROUP BY
	C_COUNT
ORDER BY
	CUSTDIST DESC,
	C_COUNT DESC;

set timing off;
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
