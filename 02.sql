select sub.ptype, cast ( avg(cast(qty as float)) as numeric(3,2))
from (	select ords_detail.ordid, ords_detail.ptype, sum(ords_detail.qty) qty
		from (	select ords.ordid ordid, products.ptype, details.qty
				from [cmpt354-hw2-db1].dbo.Orders ords, [cmpt354-hw2-db1].dbo.Details details, [cmpt354-hw2-db1].dbo.Products products
				where ords.ordid = details.ordid and details.pcode = products.pcode) ords_detail
		group by ords_detail.ordid, ords_detail.ptype) sub
group by sub.ptype;
