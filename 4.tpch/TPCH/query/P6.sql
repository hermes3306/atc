-- using 123165033 as a seed to the RNG
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;




SELECT
	SUM(L_EXTENDEDPRICE) / 7.0 AS AVG_YEARLY
FROM
	LINEITEM,
	PART
WHERE
	P_PARTKEY = L_PARTKEY
	AND P_BRAND = 'Brand#22'
	AND P_CONTAINER = 'LG DRUM'
	AND L_QUANTITY < (
		SELECT
			0.2 * AVG(L_QUANTITY)
		FROM
			LINEITEM
		WHERE
			L_PARTKEY = P_PARTKEY
	);

set timing off;
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
