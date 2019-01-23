-- using 123165034 as a seed to the RNG
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
set timing on;



CREATE VIEW REVENUE1 (SUPPLIER_NO, TOTAL_REVENUE) AS
	SELECT
		L_SUPPKEY,
		SUM(L_EXTENDEDPRICE * (1 - L_DISCOUNT))
	FROM
		LINEITEM
	WHERE
		L_SHIPDATE >= DATE'1994-07-01'
		AND L_SHIPDATE < ADD_MONTHS(DATE'1994-07-01', 3)
	GROUP BY
		L_SUPPKEY;


SELECT
	S_SUPPKEY,
	S_NAME,
	S_ADDRESS,
	S_PHONE,
	TOTAL_REVENUE
FROM
	SUPPLIER,
	REVENUE1
WHERE
	S_SUPPKEY = SUPPLIER_NO
	AND TOTAL_REVENUE = (
		SELECT
			MAX(TOTAL_REVENUE)
		FROM
			REVENUE1
	)
ORDER BY
	S_SUPPKEY;

DROP VIEW REVENUE1;

set timing off;
select to_char(systimestamp, 'YYYY-MM-DD HH-MI-SS.FF3')  from dual;
