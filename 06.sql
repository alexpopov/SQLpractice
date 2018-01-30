select orders_with_ptype.ptype, count(*)
from (	select orders_with_only_one.ordid, products.ptype
		from (	select sub.ordid
				from (	select orders.ordid, products.ptype
						from [cmpt354-hw2-db1].dbo.Orders orders, [cmpt354-hw2-db1].dbo.Details details, [cmpt354-hw2-db1].dbo.Products products
						where orders.ordid = details.ordid and details.pcode = products.pcode
						group by orders.ordid, products.ptype) sub
				group by sub.ordid
				having count(*) = 1) orders_with_only_one, [cmpt354-hw2-db1].dbo.Details details, [cmpt354-hw2-db1].dbo.Products products
		where orders_with_only_one.ordid = details.ordid and details.pcode = products.pcode
		group by orders_with_only_one.ordid, products.ptype ) orders_with_ptype
group by orders_with_ptype.ptype;