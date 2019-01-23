select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;

-- $ID$
-- TPC-H/TPC-R POTENTIAL PART PROMOTION QUERY (Q20)
-- FUNCTION QUERY DEFINITION
-- APPROVED FEBRUARY 1998
:X
:O
SELECT
	S_NAME,
	S_ADDRESS
FROM
	SUPPLIER,
	NATION
WHERE
	S_SUPPKEY IN (
		SELECT
			PS_SUPPKEY
		FROM
			PARTSUPP
		WHERE
			PS_PARTKEY IN (
				SELECT
					P_PARTKEY
				FROM
					PART
				WHERE
					P_NAME LIKE ':1%'
			)
			AND PS_AVAILQTY > (
				SELECT
					0.5 * SUM(L_QUANTITY)
				FROM
					LINEITEM
				WHERE
					L_PARTKEY = PS_PARTKEY
					AND L_SUPPKEY = PS_SUPPKEY
					AND L_SHIPDATE >= DATE':2'
					--AND L_SHIPDATE < DATE ':2' + INTERVAL '1' YEAR
					AND L_SHIPDATE < ADD_MONTHS(DATE':2', 12)
			)
	)
	AND S_NATIONKEY = N_NATIONKEY
	AND N_NAME = ':3'
ORDER BY
	S_NAME;

set timing off;
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
