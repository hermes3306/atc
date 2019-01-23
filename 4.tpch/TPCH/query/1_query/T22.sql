-- using 123165034 as a seed to the RNG
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;




SELECT
	O_ORDERPRIORITY,
	COUNT(*) AS ORDER_COUNT
FROM
	ORDERS
WHERE
	O_ORDERDATE >= DATE'1997-05-01'
		AND O_ORDERDATE < ADD_MONTHS('1997-05-01', 3)
	AND EXISTS (
		SELECT
			*
		FROM
			LINEITEM
		WHERE
			L_ORDERKEY = O_ORDERKEY
			AND L_COMMITDATE < L_RECEIPTDATE
	)
GROUP BY
	O_ORDERPRIORITY
ORDER BY
	O_ORDERPRIORITY;

set timing off;
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
