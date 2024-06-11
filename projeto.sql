CREATE SCHEMA projeto
create table projeto.usuários
(
	CPF INT,
	Nome_Comp VARCHAR(255),
	email VARCHAR(255),
	Q_máquinas int,
	Q_Agendamentos int,
	Avalia int,
	Tipo varchar(255),

	primary key(CPF)
)
create table projeto.configura
(
	ID_Config INT,
	Processador VARCHAR(255),
	RAM VARCHAR(255),
	PlacaVídeo VARCHAR(255),
	Armazenamento VARCHAR(255),
	

	primary key(ID_Config)
)
create table projeto.máquina
(
	ID int,
	CPFU int,
	Config_ID INT,
	Nome VARCHAR(255),
	ValorHora INt,
	Avaliacao INT,
	Horario time,
	Datas date,
	
	foreign key (CPFU) references projeto.usuários(CPF),
	foreign key (Config_ID) references projeto.configura(ID_Config),
	primary key(ID)
)
create table projeto.agenda
(
	ID_Agenda int,
	CPFA int,
	IDM INT,
	Duracao time,
	
	foreign key (CPFA) references projeto.usuários(CPF),
	foreign key (IDM) references projeto.máquina(ID),
	primary key(ID_Agenda)
)
create table projeto.Pessoa_Fisica
(
	CPFpf int,
	RG int,
	
	foreign key (CPFpf) references projeto.usuários(CPF)
)
create table projeto.Lan_House
(
	CPFlh int,
	CNPJ int,
	CEP int,
	Rua VARCHAR(255),
	Numero int,
	
	foreign key (CPFlh) references projeto.usuários(CPF)
)
create table projeto.FormaPagamento
(
	CPFfp int,
	Cartao int,
	
	foreign key (CPFfp) references projeto.usuários(CPF)
)
create table projeto.Telefone
(
	CPFt int,
	telefone int,
	
	foreign key (CPFt) references projeto.usuários(CPF)
)
create table projeto.Paga
(
	DataPaga date,
	Status VARCHAR(255),
	CPFp int,
	
	foreign key (CPFp) references projeto.usuários(CPF)
)
create table projeto.Dados_Bancarios
(
	Agencia int,
	Numerodb int,
	CPFdb int,
	
	foreign key (CPFdb) references projeto.usuários(CPF)
)

insert into projeto.usuários(cpf, nome_comp, email, q_máquinas, q_agendamentos, avalia, tipo) values 
(123, 'João', 'joao@gmail.com', 0, 5, 4, 'Cliente')
(456, 'Maria', 'maria@gmail.com', 2, 0, 0, 'Lan House'),
(789, 'José', 'jose@gmail.com', 3, 0, 0, 'Pessoa Física')
insert into projeto.configura(id_config, processador, ram, placavídeo, armazenamento) values 
(1, 'i5', '8GB', 'GTX 1050', '1TB'),
(2, 'i5', '16GB', 'GTX 2050', '1TB'),
(3, 'i7', '16GB', 'GTX 2060', '2TB'),
(4, 'i9', '32GB', 'GTX 3080', '4TB'),
(5, 'Ryzen 5', '8GB', 'RX 580', '1TB')
insert into projeto.máquina (id, cpfu, config_id, nome, valorhora, avaliacao, horario, datas) values 
(1, 456, 1, 'PC1', 10, 0, '10:00', '2023-02-13'),
(2, 456, 2, 'PC2', 15, 0, '12:00', '2023-07-20'),
(3, 789, 3, 'PC3', 25, 0, '14:00', '2023-08-15'),
(4, 789, 4, 'PC4', 50, 0, '16:00', '2023-09-10'),
(5, 789, 5, 'PC5', 12, 0, '18:00', '2023-10-18')

insert into projeto.agenda (id_agenda, cpfa, idm, duracao) values 
(1111, 123, 1, '01:00'),
(2222, 123, 2, '02:00'),
(3333, 123, 3, '03:00'),
(4444, 123, 4, '04:00'),
(5555, 123, 5, '05:00')


-- Apresentar a duração do agendamento por hora realizada nos últimos 6 meses.
-- Agrupar por total de horas, tipo de fornecedor e processador

select c.processador, Sum(a.duracao) as totalHoras, u.tipo
from projeto.agenda as a
left join projeto.máquina as m on m.id = a.idm
left join projeto.configura as c on c.id_config = m.config_id
left join projeto.usuários as u on u.cpf = m.cpfu
group by c.processador, u.tipo


