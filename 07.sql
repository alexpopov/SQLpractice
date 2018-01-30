select customers.custid
from [cmpt354-hw2-db1].dbo.Customers customers
where customers.custid not in (	select distinct order_with_detail.ocust
								from (	select *
										from (	select orders.ocust, orders.ordid, details.pcode
												from [cmpt354-hw2-db1].dbo.Orders orders, [cmpt354-hw2-db1].dbo.Details details
												where orders.ordid = details.ordid and details.qty <> 0 and '2016-01-01' <= orders.odate and orders.odate < '2017-01-01') order_detail
												) order_with_detail, [cmpt354-hw2-db1].dbo.Products products
								where order_with_detail.pcode = products.pcode and products.ptype = 'BOOK');
			