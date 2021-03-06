-- using 123165033 as a seed to the RNG
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;




SELECT
	SUM(L_EXTENDEDPRICE* (1 - L_DISCOUNT)) AS REVENUE
FROM
	LINEITEM,
	PART
WHERE
	(
		P_PARTKEY = L_PARTKEY
		AND P_BRAND = 'Brand#25'
		AND P_CONTAINER IN ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
		AND L_QUANTITY >= 3 AND L_QUANTITY <= 3 + 10
		AND P_SIZE BETWEEN 1 AND 5
		AND L_SHIPMODE IN ('AIR', 'AIR REG')
		AND L_SHIPINSTRUCT = 'DELIVER IN PERSON'
	)
	OR
	(
		P_PARTKEY = L_PARTKEY
		AND P_BRAND = 'Brand#44'
		AND P_CONTAINER IN ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
		AND L_QUANTITY >= 18 AND L_QUANTITY <= 18 + 10
		AND P_SIZE BETWEEN 1 AND 10
		AND L_SHIPMODE IN ('AIR', 'AIR REG')
		AND L_SHIPINSTRUCT = 'DELIVER IN PERSON'
	)
	OR
	(
		P_PARTKEY = L_PARTKEY
		AND P_BRAND = 'Brand#35'
		AND P_CONTAINER IN ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
		AND L_QUANTITY >= 26 AND L_QUANTITY <= 26 + 10
		AND P_SIZE BETWEEN 1 AND 15
		AND L_SHIPMODE IN ('AIR', 'AIR REG')
		AND L_SHIPINSTRUCT = 'DELIVER IN PERSON'
	);

set timing off;
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
