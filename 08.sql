select orders.ocust, sum(details.qty*products.price)
from (	select * 
		from [cmpt354-hw2-db1].dbo.Orders orders
		where '2016-01-01' <= orders.odate and orders.odate < '2016-07-01'
		) orders, [cmpt354-hw2-db1].dbo.Details details, [cmpt354-hw2-db1].dbo.Products products
where orders.ordid = details.ordid and details.pcode = products.pcode and products.ptype = 'MUSIC'
group by orders.ocust
having sum(details.qty*products.price) < 50

union

select customers.custid, 0
from [cmpt354-hw2-db1].dbo.Customers customers
where customers.custid not in (	select distinct orders.ocust
								from (	select * 
										from [cmpt354-hw2-db1].dbo.Orders orders
										where '2016-01-01' <= orders.odate and orders.odate < '2016-07-01'
										) orders, [cmpt354-hw2-db1].dbo.Details details, [cmpt354-hw2-db1].dbo.Products products
								where orders.ordid = details.ordid and details.pcode = products.pcode and products.ptype = 'MUSIC');