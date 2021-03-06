select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;

-- $ID$
-- TPC-H/TPC-R PRICING SUMMARY REPORT QUERY (Q1)
-- FUNCTIONAL QUERY DEFINITION
-- APPROVED FEBRUARY 1998
:X
:O
SELECT
	L_RETURNFLAG,
	L_LINESTATUS,
	SUM(L_QUANTITY) AS SUM_QTY,
	TO_CHAR(SUM(L_EXTENDEDPRICE)) AS SUM_BASE_PRICE,
	SUM(L_EXTENDEDPRICE * (1 - L_DISCOUNT)) AS SUM_DISC_PRICE,
	SUM(L_EXTENDEDPRICE * (1 - L_DISCOUNT) * (1 + L_TAX)) AS SUM_CHARGE,
	AVG(L_QUANTITY) AS AVG_QTY,
	AVG(L_EXTENDEDPRICE) AS AVG_PRICE,
	AVG(L_DISCOUNT) AS AVG_DISC,
	COUNT(*) AS COUNT_ORDER
FROM
	LINEITEM
WHERE
	L_SHIPDATE <= DATE'1998-12-01' - INTERVAL':1'
GROUP BY
	L_RETURNFLAG,
	L_LINESTATUS
ORDER BY
	L_RETURNFLAG,
	L_LINESTATUS;

set timing off;
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
