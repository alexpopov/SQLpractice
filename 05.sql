select final_sub.ocust, count(*) total_num, cast(avg(final_sub.summ) as numeric(5,2)) avg_spend
from (	select *
		from (	Select orders.ordid, sum(details.qty*products.price) summ, orders.ocust
				From [cmpt354-hw2-db1].dbo.Details details, [cmpt354-hw2-db1].dbo.Orders orders, [cmpt354-hw2-db1].dbo.Products products
				Where details.ordid = orders.ordid and details.pcode = products.pcode
				group by  orders.ordid, orders.ocust) sub

		union

		select orders.ordid, cast(0 as float), orders.ocust
		from [cmpt354-hw2-db1].dbo.Orders orders
		where orders.ordid not in ( select details.ordid
								from [cmpt354-hw2-db1].dbo.Details details) ) final_sub
group by final_sub.ocust;



							
