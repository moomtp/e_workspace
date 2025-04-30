source :  https://b23.tv/1zz0Ewb
### CRUD

- insert
- delete
- update
- select

其他常用的參數
- from 來源 insert into

- where 條件 having 函數結果條件
可用的聚合函數 ： sum count max min avg

```
use Northwind
go
create table tl(id int, name char(10))

insert into tl values(1,'tom'), (2,'amy'), (3,'bob')
select * from tl*
update tl set name='tommy' where name='tom'
delete tl where id=1

go


```

### 查詢
關鍵字(6個)
- select 列名/函數運算/計算公式
- from 表名    (從哪查詢, 可以是多個表)
- where 條件表達式(= > <...等)
- group by  (分組, 分類)
- having 條件表達式  （函數條件）
- order by  (升序asc, 降序desc)
注意 ： 
1. select 後面出現聚合函數, 原列表必須寫進group by
2.  有having, 就有group by


```
select * from Products

select CompanyName, ContactNme, phone from [Customers]
where Phone='0966555'
go

select count(CompanyName) from Customers
go

-- 會直接呈現計算好的結果
select OrderID,UnitPrice*Quantity*(1-Discount) from [Order Details]
go

select CatagoryID, count(ProductName) from Products group by CategoryID
go


select OrderID,sum(UnitPrice*Quantity*(1-Discount)) from [Order Details]
group by OrderID
having sum(UnitPrice*Quantity*(1-Discount)) > 3000
go

select OrderID,sum(UnitPrice*Quantity*(1-Discount)) as t_price from [Order Details]
order by t_price desc
go

```


### 排重 & top k

排重與top k
```
select count(distinct country) from Customers



select top 10 with ties
select ProductName,UnitPirce from Products order by UnitPrice desc
go
```

### 多表查詢

一定會有where, 不然會爆量
多表查詢代表兩表有關-> 一定有相同的列
將相同的列作為尋找的方式

雙表查詢(找出在EmployID相同的元素)
```
select OrderID, CustomerID, FirstName from Orders, Employees where orders.EmployID=Employees.EmployID


```

多表查詢join on(定單表：訂單ID, 產品單：產品ID, 客戶表:客户名, 員工表：員工名,訂單表：成交額)

產品表-訂單表-客戶表
		 ｜
		員工表

列出每一筆訂單的明細
```
select o.OrderID, p.ProductName, c.CompanyName, e.FirstName + ' ' + e.LastName fullname, os.UnitPrice*os.Quantity*(1-os.Discount) price
from Orders o join Customers c on c.CustomerID=o.CUstomerID
	join Employees e on e.EmployeeID=o.EmployeeID
	join [Order Details] os on os.OrderID=o.OrderID
	join Products p on p.ProductID=os.ProductID
go

```

有多表建議用畫圖的方式呈現結構


### 用join on 列出表格

列出沒有訂單的客戶 (求 a && !b)
```
select c.CompanyName, o.OrderID
from Customers c left join Orders o on c.CustomerID=o.CustomerID
where o.OrderID is null
```

left join 代表想要找 a && !b
使用left join會把null的也找進來, 再用where is null找空值


購買單 -- 產品表
列出購買量前10的客戶
```
select top 10 with ties
	c.CompanyName, sum(os.UnitPrice*os.Quantity*(1-os.Discount)) price
from Cuntomers c join [Order Detail] os on os.OrderID=o.OrdedrID
	join Orders o on o.CustomerID=c.CustomerID
group by c.CompanyName
order by price desc
go
```

員工名 --購買單 -- 產品表
列出銷售前5的員工
```
select top 5 with ties
	e.FirstName+ ' ' + e.LastName fullname, sum(os.UnitPrice*os.Quantity*(1-os.Discount)) price
from Employees e join Orders o on e.EmployeeID=o.EmployeeID
	join [Order Details] os on os.OrderID=o.OrderID
group by e.FirstName+ ' ' + e.LastName
order by price desc
```

列出購買量>100000, 或下單超過10次的客戶(不排重, 不要加distinct)

```
select c.CompanyName, 
	sum(os.UnitPrice*os.Quantity*(1-os.Discount)) price, 
	count (os.OrderID) 
from Customer c join Orders o on c.CustomerID=o.CustomerID
	join [Order Details] os on os.OrderID=o.OrderID
group by c.CompanyName 
having sum(os.UnitPrice*os.Quantity*(1-os.Discount)) > 100000 
```


### 月/年報表

關鍵在日期
```
select year(o.OrderDate), month(o.orderDate), os.UnitPrice*os.Quantity*(1-os.Discount), sum(os.UnitPrice*os.Quantity*(1-os.Discount)) price
from Orders o join [Order Details] os on os.OrderID=o.OrderID
group by year(o.OrderDate), month(o.OrderDate)
order by year,month
go
```

每月5號發送去年當月月報
```

select year(o.OrderDate), month(o.orderDate), os.UnitPrice*os.Quantity*(1-os.Discount), sum(os.UnitPrice*os.Quantity*(1-os.Discount)) price
from Orders o join [Order Details] os on os.OrderID=o.OrderID
where o.year(o.OrderDate)=year(getdate())-1
group by year(o.OrderDate), month(o.OrderDate)
order by year,month
go
```