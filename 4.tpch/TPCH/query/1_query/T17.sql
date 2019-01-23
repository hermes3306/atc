-- using 123165034 as a seed to the RNG
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;




SELECT
	100.00 * SUM(CASE
		WHEN P_TYPE LIKE 'PROMO%'
			THEN L_EXTENDEDPRICE * (1 - L_DISCOUNT)
		ELSE 0
	END) / SUM(L_EXTENDEDPRICE * (1 - L_DISCOUNT)) AS PROMO_REVENUE
FROM
	LINEITEM,
	PART
WHERE
	L_PARTKEY = P_PARTKEY
	AND L_SHIPDATE >= DATE'1993-06-01'
		AND L_SHIPDATE < ADD_MONTHS(DATE'1993-06-01', 1);

set timing off;
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
