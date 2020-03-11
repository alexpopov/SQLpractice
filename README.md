# Cmpt354Queries

Schema
```
CREATE TABLE Customers (  -- df: mult=1
    custid   INTEGER PRIMARY KEY,
    cname    VARCHAR(14), -- df: word=names.txt sub=power rate=0.016
    country  CHAR(3)      -- df: word=:GBR,USA,ITA,CHN,JPN
);

CREATE TABLE Products (   -- df: size=1000
    pcode    INTEGER PRIMARY KEY,
    pname    VARCHAR(10),
    pdesc    VARCHAR(20),
    ptype    VARCHAR(20),  -- df: word=:MUSIC,BOOK,MOVIE
    price    NUMERIC(6,2), -- df: float=gauss alpha=10 beta=3
    CHECK ( price > 0 )
);

CREATE TABLE Orders (     -- df: mult=20
    ordid    INTEGER PRIMARY KEY,
    odate    DATE,        -- df: start=2015-01-01 end=2016-09-30
    ocust    INTEGER NOT NULL REFERENCES Customers -- df: null=0
);

CREATE TABLE Details (    -- df: mult=40
    ordid    INTEGER REFERENCES Orders,   -- df: null=0
    pcode    INTEGER REFERENCES Products, -- df: null=0
    qty      SMALLINT,    -- df: int size=3 sub=power alpha=10
    PRIMARY KEY (ordid, pcode)
);

CREATE TABLE Invoices (    -- df: nogen
    invid    INTEGER PRIMARY KEY,
    ordid    INTEGER NOT NULL UNIQUE REFERENCES Orders,
    amount   NUMERIC(8,2) CHECK ( amount > 0 ),
    issued   DATE,
    due      DATE,
    CHECK ( due >= issued )
);
```

Queries in Natural language

(01) Total number of orders placed in 2016 by customers of each country. If all customers from a specific country did not place any orders in 2016, the country appears in the output with 0 total orders. Return all countries and corresponding total counts.

 (02) For each product type calculate the average number of times products of that type have been included in an order (taking into account quantities). Orders that do not include any product of a certain type do not contribute to the average for that type (rather than contributing 0). Return the product type and the corresponding average; the latter must be a number with exactly two decimal places. Types of products that have never been ordered are not included in the output.

 (03) Find invoices that have been taxed. The amount of such invoices is the total of the order they refer to plus 20% of tax. Return the invoice ID. Keep in mind the datatype of “amount” in invoices and pay special attention to rounding.

 (04) For each type of product, find the customer who ordered the highest number of products of that type (taking into account quantities). Return the product type and the ID of the customer. If two or more customers are tied for a specific product type they will all be included in the output. If no products of a specific type have ever been ordered, that type will not be in the output. 1 

(05) For each customer, calculate the number of orders placed and the average spend, which is the average total (taking into account quantities and unit prices of ordered products) across all orders placed by that customer. Return the customer ID, the number of orders, and the corresponding average spend. The latter must be a number with exactly two decimal places. Orders without detail must be considered in the calculation of the average as having a total of 0. Customers who did not place any orders will be included in the output with 0 orders (not 0.00 or anything else, just 0) and NULL average spend.

 (06) For each product type, calculate the number of orders consisting only of products of that type. Return the product type and the number of orders.

 (07) Find “poor readers”: customers who have not purchased any books in 2016. Return the customer ID. 

(08) Find customers who spent less than 50 in music in the period between January and June 2016 (extremes included). Return the customer ID and the corresponding spend. Customers who have not bought any music in the given period must be returned with 0.00 spend (precisely in this form). 

(09) For each customer who has placed at least two orders, calculate the longest number of days ever elapsed between any one order and the next. The only case in which this interval (which you can calculate as the difference of two dates) will be zero is for customers who placed at least two orders and all of them were placed in the same day. Whether an order has a detail is irrelevant. Return the customer ID and the corresponding interval (which will be an integer). 

(10) Find customers who have placed at least 5 orders, all in different dates, and the interval between any one of their orders and the next (not on the same date) is less than 30 days on average. The interval between any two orders placed in the same day (which is 0) does not contribute to the average. Whether an order has a detail or not is irrelevant. Return the customer ID only.
