select sub.ptype, sub.ocust
from (	select products.ptype, orders.ocust, sum(details.qty) qty
		from [cmpt354-hw2-db1].dbo.Details details, [cmpt354-hw2-db1].dbo.Products products, [cmpt354-hw2-db1].dbo.Orders orders
		where details.pcode = products.pcode and details.ordid = orders.ordid
		group by orders.ocust, products.ptype) sub
where sub.qty >= all (	select sum(details.qty) qty
						from [cmpt354-hw2-db1].dbo.Details details, [cmpt354-hw2-db1].dbo.Products products, [cmpt354-hw2-db1].dbo.Orders orders
						where products.ptype = sub.ptype and details.pcode = products.pcode and details.ordid = orders.ordid
						group by orders.ocust, products.ptype);