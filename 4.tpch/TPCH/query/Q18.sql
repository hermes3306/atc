SELECT C_NAME,
       C_CUSTKEY,
       O_ORDERKEY,
       O_ORDERDATE,
       O_TOTALPRICE,
       SUM(L_QUANTITY)
FROM CUSTOMER,
     ORDERS,
     LINEITEM
WHERE O_ORDERKEY IN ( SELECT L_ORDERKEY
                      FROM LINEITEM
                      GROUP BY L_ORDERKEY 
                      HAVING SUM(L_QUANTITY) > 300 )
  AND C_CUSTKEY = O_CUSTKEY
  AND O_ORDERKEY = L_ORDERKEY
GROUP BY C_NAME,
         C_CUSTKEY,
         O_ORDERKEY,
         O_ORDERDATE,
         O_TOTALPRICE
ORDER BY O_TOTALPRICE DESC,
         O_ORDERDATE
LIMIT 100;