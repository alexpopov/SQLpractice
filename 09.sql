select sub.ocust, max(sub.datedif)
from (	select order_left.ocust, datediff("D",order_left.odate,min(order_right.odate)) datedif
		from [cmpt354-hw2-db1].dbo.Orders order_left, [cmpt354-hw2-db1].dbo.Orders order_right
		where order_left.ocust = order_right.ocust and order_left.odate < order_right.odate and order_left.ocust in (	select orders.ocust
																														from [cmpt354-hw2-db1].dbo.Orders orders
																														group by orders.ocust
																														having count(orders.ordid) >=2)
		group by order_left.ocust, order_left.odate) sub
group by sub.ocust

union

select orders.ocust, 0
from [cmpt354-hw2-db1].dbo.Orders orders
group by orders.ocust
having count(orders.ordid) >=2 and datediff("D", max(orders.odate),min(orders.odate)) = 0;