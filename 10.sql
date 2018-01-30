select ocust_with_consecutive_dates.ocust
from (	select sub_left.ocust, datediff("d",sub_left.odate, min(sub_right.odate)) date_diff
		from (	select orders.ocust, orders.odate
				from [cmpt354-hw2-db1].dbo.Orders orders
				where orders.ocust in (	select sub.ocust
										from (	select orders.ocust, orders.odate
												from [cmpt354-hw2-db1].dbo.Orders orders
												group by orders.ocust, orders.odate ) sub
										group by sub.ocust
										having count(*) >= 5)
				group by orders.ocust, orders.odate ) sub_left,
			(	select orders.ocust, orders.odate
				from [cmpt354-hw2-db1].dbo.Orders orders
				where orders.ocust in (	select sub.ocust
										from (	select orders.ocust, orders.odate
												from [cmpt354-hw2-db1].dbo.Orders orders
												group by orders.ocust, orders.odate ) sub
										group by sub.ocust
										having count(*) >= 5)
				group by orders.ocust, orders.odate ) sub_right
		where sub_left.ocust = sub_right.ocust and sub_left.odate < sub_right.odate
		group by sub_left.ocust, sub_left.odate) ocust_with_consecutive_dates
group by ocust_with_consecutive_dates.ocust
having avg(ocust_with_consecutive_dates.date_diff) < 30
order by ocust_with_consecutive_dates.ocust;