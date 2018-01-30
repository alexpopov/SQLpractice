Select country_ord.country, count(*) num
from (
	select custs.country country, ords.ordid orderID
	from [cmpt354-hw2-db1].dbo.Customers custs, [cmpt354-hw2-db1].dbo.Orders ords
	where custs.custid = ords.ocust and  '2016-01-01' <= ords.odate and ords.odate < '2017-01-01'
	) country_ord
group by country_ord.country

union

select customer.country, 0
from [cmpt354-hw2-db1].dbo.Customers customer
where customer.country not in ( 	select custs.country country
									from [cmpt354-hw2-db1].dbo.Customers custs, [cmpt354-hw2-db1].dbo.Orders ords
									where custs.custid = ords.ocust and  '2016-01-01' <= ords.odate and ords.odate < '2017-01-01');