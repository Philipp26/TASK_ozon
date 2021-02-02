declare @Producers table
(
	id int not null
	,name nvarchar(256)
)

declare @TradeMarks table 
(
	id int not null
	,ProducerId int not null
	,name nvarchar(256)
)

insert into @Producers (id, name)
values
(1, 'Coca-Cola'),
(2, 'Pepsi'),
(3, 'Вим-Биль-Дан'),
(4, 'Сады придонья')

insert into @TradeMarks (id, producerId, [name])
values
(1, 1, 'rich'),
(2, 1, 'моя семья'),
(3, 1, 'добрый'),
(4, 2, 'Фрутковый сад'),
(5, 2, 'Любимый'),
(6, 2, 'Bon Aqua'),
(7, 3, 'Агуша'),
(8, 3, 'j7')

select 'Задание 1.1'
select 
	 prods.[name]					[Producer Name]
	,TMark.[name]					[TradeMark Name]			
from @TradeMarks TMark 
	join @Producers prods on prods.id = TMark.ProducerId
where prods.name = 'Coca-Cola'

select 'Задание 1.2'
select 
	prods.[name]					[Producer Name]
from @Producers prods
where prods.id not in
(
	select ProducerId from @TradeMarks
)

select 'Задание 1.3'
select 
	 prods.[name]					[Producer Name]
	,count(TMark.[name])			[TradeMark Count]			
from @TradeMarks TMark 
	join @Producers prods on prods.id = TMark.ProducerId
group by prods.[name]


declare @Hierarchy table
(
	obj				nvarchar(64)					
	,parent_obj		nvarchar(64)
)

insert into @Hierarchy
values
('Сеть магазинов', null),
('Магазин1', 'Сеть магазинов'),
('Магазин2', 'Сеть магазинов'),
('Рыба', 'Магазин1'),
('Мясо', 'Магазин1'),
('Фрукты', 'Магазин2'),
('Хлеб', 'Магазин2'),
('Рыба', 'Магазин2'),
('Булка', 'Хлеб'),
('Карась', 'Рыба'),
('Окунь', 'Рыба'),
('Бивштекс', 'Мясо'),
('Фарш', 'Мясо'),
('Банан', 'Фрукты'),
('Апельсин', 'Фрукты')

select 'Задание 2'
;with HierarchyTree([child], [parent])
as 
(
	select obj, parent_obj
	from @Hierarchy
	where parent_obj = 'Сеть магазинов'
	union all
	select obj, parent_obj
	from @Hierarchy h 
		join HierarchyTree HTree on h.parent_obj = HTree.[child]		 
)
select [parent], [child]  
from HierarchyTree

