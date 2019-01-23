-- using 123165034 as a seed to the RNG
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;




SELECT
	SUM(L_EXTENDEDPRICE * L_DISCOUNT) AS REVENUE
FROM
	LINEITEM
WHERE
	L_SHIPDATE >= DATE'1996-01-01'
		AND L_SHIPDATE < ADD_MONTHS('1996-01-01', 12)
	AND L_DISCOUNT BETWEEN 0.09 - 0.01 AND 0.09 + 0.01
	AND L_QUANTITY < 25;

set timing off;
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
