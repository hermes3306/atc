-- using 123165033 as a seed to the RNG
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;




SELECT
	PS_PARTKEY,
	SUM(PS_SUPPLYCOST * PS_AVAILQTY) AS VALUE
FROM
	PARTSUPP,
	SUPPLIER,
	NATION
WHERE
	PS_SUPPKEY = S_SUPPKEY
	AND S_NATIONKEY = N_NATIONKEY
	AND N_NAME = 'MOROCCO'
GROUP BY
	PS_PARTKEY HAVING
		SUM(PS_SUPPLYCOST * PS_AVAILQTY) > (
			SELECT
				SUM(PS_SUPPLYCOST * PS_AVAILQTY) * 0.0001000000
			FROM
				PARTSUPP,
				SUPPLIER,
				NATION
			WHERE
				PS_SUPPKEY = S_SUPPKEY
				AND S_NATIONKEY = N_NATIONKEY
				AND N_NAME = 'MOROCCO'
		)
ORDER BY
	VALUE DESC;

set timing off;
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
