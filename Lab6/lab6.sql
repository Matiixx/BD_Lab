-- 1
WITH zamowienia
     AS (SELECT customer_id,
                Sum(CASE
                      WHEN sell_price - cost_price < 0 THEN 1
                      ELSE 0
                    END) AS Strata,
                Sum(CASE
                      WHEN sell_price - cost_price >= 0
                           AND sell_price - cost_price <= 4 THEN 1
                      ELSE 0
                    END) AS Zysk,
                Sum(CASE
                      WHEN sell_price - cost_price > 4 THEN 1
                      ELSE 0
                    END) AS Super
         FROM   orderinfo
                JOIN orderline using(orderinfo_id)
                JOIN item using(item_id)
         GROUP  BY customer_id)
SELECT lname,
       strata,
       zysk,
       super
FROM   zamowienia
       JOIN customer using(customer_id)
ORDER  BY customer_id; 

--2
SELECT empno as emp_no,
       empname as emp_name,
       mgrno as mgr_no,
       (SELECT empname
        FROM   staff s2
        WHERE  s2.empno = s.mgrno) as mgr_name
FROM   staff s
WHERE  mgrno IS NOT NULL; 

--3
WITH recursive mgr AS
(
       SELECT *,
              1 AS lvl
       FROM   staff s
       WHERE  empno = 100
       UNION
       SELECT s2.*,
              lvl+1 AS lvl
       FROM   staff s2
       JOIN   mgr m
       ON     (
                     s2.mgrno = m.empno) )
SELECT empname,
       (
              SELECT empname
              FROM   staff s
              WHERE  s.empno = m.mgrno) as mgrname,
       lvl
FROM   mgr m;

--4
WITH recursive hierarchia AS
(
       SELECT *,
              1  AS lvl,
              '' AS hier
       FROM   staff
       WHERE  empno = 100
       UNION
       SELECT s.*,
              lvl+1 AS lvl,
              concat_ws('->', hier, h.empname)
       FROM   staff s
       JOIN   hierarchia h
       ON     (
                     h.empno = s.mgrno) )
SELECT empname,
       lvl,
       hier
FROM   hierarchia;