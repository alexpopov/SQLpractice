select after_tax.invid
from(
		select invoice.invid, cast(sum(details.qty*products.price)*1.2 as numeric(5,2)) amount
		from [cmpt354-hw2-db1].dbo.Invoices invoice, [cmpt354-hw2-db1].dbo.Details details, [cmpt354-hw2-db1].dbo.Orders orders, [cmpt354-hw2-db1].dbo.Products products
		where invoice.ordid = orders.ordid and details.ordid = orders.ordid and details.pcode = products.pcode
		group by invoice.invid
	) after_tax,
	(
		select invoice.invid, invoice.amount
		from [cmpt354-hw2-db1].dbo.Invoices invoice
	) invoices
where after_tax.invid = invoices.invid and after_tax.amount = invoices.amount;