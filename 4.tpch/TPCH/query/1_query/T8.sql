-- using 123165034 as a seed to the RNG
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;




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
					P_NAME LIKE 'dark%'
			)
			AND PS_AVAILQTY > (
				SELECT
					0.5 * SUM(L_QUANTITY)
				FROM
					LINEITEM
				WHERE
					L_PARTKEY = PS_PARTKEY
					AND L_SUPPKEY = PS_SUPPKEY
					AND L_SHIPDATE >= DATE'1995-01-01'
										AND L_SHIPDATE < ADD_MONTHS(DATE'1995-01-01', 12)
			)
	)
	AND S_NATIONKEY = N_NATIONKEY
	AND N_NAME = 'FRANCE'
ORDER BY
	S_NAME;

set timing off;
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
