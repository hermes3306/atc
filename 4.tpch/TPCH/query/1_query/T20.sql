-- using 123165034 as a seed to the RNG
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;




SELECT
	CNTRYCODE,
	COUNT(*) AS NUMCUST,
	SUM(C_ACCTBAL) AS TOTACCTBAL
FROM
	(
		SELECT
						SUBSTRING(C_PHONE, 1, 2) AS CNTRYCODE,
			C_ACCTBAL
		FROM
			CUSTOMER
		WHERE
			SUBSTRING(C_PHONE, 1, 2) IN
				('16', '23', '31', '30', '32', '19', '33')
			AND C_ACCTBAL > (
				SELECT
					AVG(C_ACCTBAL)
				FROM
					CUSTOMER
				WHERE
					C_ACCTBAL > 0.00
					AND SUBSTRING(C_PHONE, 1, 2) IN
						('16', '23', '31', '30', '32', '19', '33')
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
