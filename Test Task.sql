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
(3, '���-����-���'),
(4, '���� ��������')

insert into @TradeMarks (id, producerId, [name])
values
(1, 1, 'rich'),
(2, 1, '��� �����'),
(3, 1, '������'),
(4, 2, '��������� ���'),
(5, 2, '�������'),
(6, 2, 'Bon Aqua'),
(7, 3, '�����'),
(8, 3, 'j7')

select '������� 1.1'
select 
	 prods.[name]					[Producer Name]
	,TMark.[name]					[TradeMark Name]			
from @TradeMarks TMark 
	join @Producers prods on prods.id = TMark.ProducerId
where prods.name = 'Coca-Cola'

select '������� 1.2'
select 
	prods.[name]					[Producer Name]
from @Producers prods
where prods.id not in
(
	select ProducerId from @TradeMarks
)

select '������� 1.3'
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
('���� ���������', null),
('�������1', '���� ���������'),
('�������2', '���� ���������'),
('����', '�������1'),
('����', '�������1'),
('������', '�������2'),
('����', '�������2'),
('����', '�������2'),
('�����', '����'),
('������', '����'),
('�����', '����'),
('��������', '����'),
('����', '����'),
('�����', '������'),
('��������', '������')

select '������� 2'
;with HierarchyTree([child], [parent])
as 
(
	select obj, parent_obj
	from @Hierarchy
	where parent_obj = '���� ���������'
	union all
	select obj, parent_obj
	from @Hierarchy h 
		join HierarchyTree HTree on h.parent_obj = HTree.[child]		 
)
select [parent], [child]  
from HierarchyTree

