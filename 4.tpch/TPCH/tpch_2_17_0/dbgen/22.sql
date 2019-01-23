select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;

-- $ID$
-- TPC-H/TPC-R GLOBAL SALES OPPORTUNITY QUERY (Q22)
-- FUNCTIONAL QUERY DEFINITION
-- APPROVED FEBRUARY 1998
:X
:O
SELECT
	CNTRYCODE,
	COUNT(*) AS NUMCUST,
	SUM(C_ACCTBAL) AS TOTACCTBAL
FROM
	(
		SELECT
			--SUBSTRING(C_PHONE FROM 1 FOR 2) AS CNTRYCODE,
			SUBSTRING(C_PHONE, 1, 2) AS CNTRYCODE,
			C_ACCTBAL
		FROM
			CUSTOMER
		WHERE
			SUBSTRING(C_PHONE, 1, 2) IN
				(':1', ':2', ':3', ':4', ':5', ':6', ':7')
			AND C_ACCTBAL > (
				SELECT
					AVG(C_ACCTBAL)
				FROM
					CUSTOMER
				WHERE
					C_ACCTBAL > 0.00
					AND SUBSTRING(C_PHONE, 1, 2) IN
						(':1', ':2', ':3', ':4', ':5', ':6', ':7')
			)
			AND NOT EXISTS (
				SELECT
					*
				FROM
					ORDERS
				WHERE
					O_CUSTKEY = C_CUSTKEY
			)
	) CUSTSALE
GROUP BY
	CNTRYCODE
ORDER BY
	CNTRYCODE;

set timing off;
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
