SELECT L_SHIPMODE,
       SUM( CASE2 ( O_ORDERPRIORITY = '1-URGENT' OR O_ORDERPRIORITY = '2-HIGH',
                   1, 0 ) ) AS HIGH_LINE_COUNT,
       SUM ( CASE2 ( O_ORDERPRIORITY <> '1-URGENT' AND 
                    O_ORDERPRIORITY <> '2-HIGH', 1, 0 ) ) AS LOW_LINE_COUNT
FROM ORDERS,
     LINEITEM
WHERE O_ORDERKEY = L_ORDERKEY
  AND L_SHIPMODE IN ('MAIL', 'SHIP')
  AND L_COMMITDATE < L_RECEIPTDATE
  AND L_SHIPDATE < L_COMMITDATE
  AND L_RECEIPTDATE >= DATE'1994-01-01'
  AND L_RECEIPTDATE < ADD_MONTHS(DATE'1994-01-01', 12)
GROUP BY L_SHIPMODE
ORDER BY L_SHIPMODE; 