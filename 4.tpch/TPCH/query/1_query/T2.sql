-- using 123165034 as a seed to the RNG
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;




SELECT
	L_ORDERKEY,
	SUM(L_EXTENDEDPRICE * (1 - L_DISCOUNT)) AS REVENUE,
	O_ORDERDATE,
	O_SHIPPRIORITY
FROM
	CUSTOMER,
	ORDERS,
	LINEITEM
WHERE
	C_MKTSEGMENT = 'AUTOMOBILE'
	AND C_CUSTKEY = O_CUSTKEY
	AND L_ORDERKEY = O_ORDERKEY
	AND O_ORDERDATE < DATE'1995-03-29'
	AND L_SHIPDATE > DATE'1995-03-29'
GROUP BY
	L_ORDERKEY,
	O_ORDERDATE,
	O_SHIPPRIORITY
ORDER BY
	REVENUE DESC,
	O_ORDERDATE
LIMIT 10;

set timing off;
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
