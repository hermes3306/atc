select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;

-- $ID$
-- TPC-H/TPC-R SMALL-QUANTITY-ORDER REVENUE QUERY (Q17)
-- FUNCTIONAL QUERY DEFINITION
-- APPROVED FEBRUARY 1998
:X
:O
SELECT
	SUM(L_EXTENDEDPRICE) / 7.0 AS AVG_YEARLY
FROM
	LINEITEM,
	PART
WHERE
	P_PARTKEY = L_PARTKEY
	AND P_BRAND = ':1'
	AND P_CONTAINER = ':2'
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
