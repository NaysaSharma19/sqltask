show tables;

select * from salesorderdetail;
select * from product;

select product.ProductID, name, UnitPrice from salesorderdetail
join product on product.productID= salesorderdetail.productID
where unitprice>50;

SELECT 
    YEAR(h.ModifiedDate) AS OrderYear, 
    CASE MONTH(h.ModifiedDate)
        WHEN 1 THEN 'Jan'
        WHEN 2 THEN 'Feb'
        WHEN 3 THEN 'Mar'
        WHEN 4 THEN 'Apr'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'Jun'
        WHEN 7 THEN 'Jul'
        WHEN 8 THEN 'Aug'
        WHEN 9 THEN 'Sep'
        WHEN 10 THEN 'Oct'
        WHEN 11 THEN 'Nov'
        WHEN 12 THEN 'Dec'
    END AS OrderMonth,
    COUNT(d.SalesOrderID) AS TotalOrders
FROM SalesOrderDetail d
JOIN SalesOrderHeader h ON d.SalesOrderID = h.SalesOrderID
GROUP BY 
    YEAR(h.ModifiedDate), 
    MONTH(h.ModifiedDate)
ORDER BY 
    OrderYear, 
    MONTH(h.ModifiedDate);

select * from salesorderdetail;

select salesdetail.customerid, name, rownumber(*) over (PARTITION BY from salesdetail.customerid) AS TOTALORDERS FROM salesdetail
JOIN CUSTOMER ON customer.customerid=salesdetail.customerid
WHERE count(*) over (PARTITION BY from salesdetail.customerid)>1
ORDER BY salesdetail.customerid;
