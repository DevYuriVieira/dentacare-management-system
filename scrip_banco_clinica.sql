-- criando banco de dados

create database clinica_odontologica;

-- setando o banco a ser usado

use clinica_odontologica;

-- criando as tabelas do banco de dados

create table dentista(
	id serial primary key,
	nome_completo varchar(100) not null,
	cpf varchar(11) not null unique check(cpf ~ '^[0-9]{11}$'),
	cro varchar(20) not null unique,
	especialidade varchar(80) not null,
	email varchar(100) unique
);

create table horario_atendimento(
	id serial primary key,
	id_dentista int not null,
	dia_semana varchar(15) not null
		check(dia_semana in('Segunda', 'Terca', 'Quarta', 'Quinta', 'Sexta', 'Sabado', 'Domingo')),
	hora_inicio time not null,
	hora_fim time not null check(hora_fim > hora_inicio),
	foreign key (id_dentista) references dentista(id) on delete cascade
);

create table paciente(
  	id serial primary key,
	nome_completo varchar (100) not null,
	cpf varchar (11) not null unique check(cpf ~ '^[0-9]{11}$'),
	data_nascimento date not null check(data_nascimento < current_date),
	telefone varchar (20) not null,
	email varchar (100) unique,
	endereco varchar (200)
);

create table consulta(
	id serial primary key,
	id_paciente int not null,
	id_dentista int not null,
	foreign key (id_paciente) references paciente (id) on delete restrict,
	foreign key (id_dentista) references dentista (id) on delete restrict,
	data_consulta timestamp not null,
	status varchar (20) not null
		check (status in ('Realizada', 'Agendada','Cancelada')),
	descricao_atendimento text,
	prescricao text
);

create table procedimento (
	id serial primary key,
	nome varchar(100) not null unique,
	descricao text,
	duracao_media_min int not null check (duracao_media_min > 0)
);

create table consulta_procedimento (
	id_consulta int not null,
	id_procedimento int not null,
	primary key (id_consulta, id_procedimento),
	foreign key (id_consulta) references consulta(id) on delete cascade,
	foreign key (id_procedimento) references procedimento(id) on delete restrict
);

-- REQUISITOS NÃO FUNCIONAIS
-- inserção de dados nas tabelas 

insert into paciente (nome_completo, cpf, data_nascimento, telefone, email, endereco)
values ('Ana Souza Lima', '25097312031', '1990-05-14', '21983111506', 'ana.souza@email.com', 'Rua das Laranjeiras, 120 - Laranjeiras, Rio de Janeiro - RJ'),
   ('Bruno Almeida Costa', '11169332099', '1985-09-22', '24979268832', 'bruno.almeida@email.com', 'Avenida Nossa Senhora de Copacabana, 450 - Copacabana, Rio de Janeiro - RJ'),
   ('Carla Mendes Rocha', '56455870069', '1998-01-10', '22975705105', 'carla.mendes@email.com', 'Rua do Catete, 88 - Catete, Rio de Janeiro - RJ'),
   ('Daniel Pereira Santos', '29269505006', '1979-11-03', '21969906812', 'daniel.pereira@email.com', 'Rua São Clemente, 201 - Botafogo, Rio de Janeiro - RJ'),
   ('Eduarda Martins Silva', '77102474075', '2000-07-19', '24998784313', 'eduarda.martins@email.com', 'Avenida Brasil, 990 - Benfica, Rio de Janeiro - RJ'),
   ('Felipe Rodrigues Nunes', '71518588093', '1993-03-27', '21973812771', 'felipe.rodrigues@email.com', 'Rua Voluntários da Pátria, 56 - Botafogo, Rio de Janeiro - RJ'),
   ('Gabriela Ferreira Alves', '02839097060', '1988-12-08', '22988285205', 'gabriela.ferreira@email.com', 'Rua Haddock Lobo, 34 - Tijuca, Rio de Janeiro - RJ'),
   ('Henrique Barros Melo', '64667438029', '1995-06-30', '24974602117', 'henrique.barros@email.com', 'Rua Dias da Cruz, 145 - Méier, Rio de Janeiro - RJ'),
   ('Isabela Cardoso Pinto', '81159266042', '1982-04-12', '22986957224', 'isabela.cardoso@email.com', 'Rua Conde de Bonfim, 300 - Tijuca, Rio de Janeiro - RJ'),
   ('João Victor Ramos', '45347505010', '1999-08-25', '24982406883', 'joaovictor.ramos@email.com', 'Avenida Atlântica, 700 - Copacabana, Rio de Janeiro - RJ');

insert into dentista (nome_completo, cpf ,cro, especialidade, email)
values('Ricardo Teixeira', '84849217001', 'CRO-RJ-2098', 'Ortodontia', 'ricardo.teixeira@clinica.com'),
   ('Mariana Lopes', '26748455030', 'CRO-RJ-4837', 'Endodontia', 'mariana.lopes@clinica.com'),
   ('Paulo Henrique', '54735263063', 'CRO-RJ-0239', 'Implantodontia', 'paulo.henrique@clinica.com'),
   ('Fernanda Castro', '56711300009', 'CRO-RJ-1627', 'Odontopediatria', 'fernanda.castro@clinica.com'),
   ('Gustavo Freitas', '14098006014', 'CRO-RJ-9378', 'Clínico Geral', 'gustavo.freitas@clinica.com'),
   ('Juliana Moraes', '90496212010', 'CRO-RJ-6837', 'Periodontia', 'juliana.moraes@clinica.com'),
   ('André Carvalho', '15261481023', 'CRO-RJ-5237', 'Cirurgia Bucomaxilofacial', 'andre.carvalho@clinica.com'),
   ('Patrícia Gomes', '73215920069', 'CRO-RJ-2561', 'Prótese Dentária', 'patricia.gomes@clinica.com'),
   ('Leonardo Azevedo', '33115355025', 'CRO-RJ-3275', 'Estética Dental', 'leonardo.azevedo@clinica.com'),
   ('Camila Ribeiro', '70620188057', 'CRO-RJ-7238', 'Radiologia Odontológica', 'camila.ribeiro@clinica.com');

insert into procedimento (nome,descricao, duracao_media_min)
values ('Limpeza', 'Procedimento de profilaxia e remoção de placa bacteriana.', 40),
   ('Restauração', 'Recuperação de dentes com cárie ou fratura.', 60),
   ('Canal', 'Tratamento endodôntico para remoção da polpa inflamada.', 90),
   ('Extração', 'Remoção de dente comprometido.', 45),
   ('Clareamento', 'Procedimento estético para clarear os dentes.', 50),
   ('Implante Dentário', 'Instalação de implante para reposição dentária.', 120),
   ('Aparelho Ortodôntico', 'Instalação e ajuste de aparelho ortodôntico.', 70),
   ('Avaliação Clínica', 'Consulta inicial para diagnóstico e planejamento.', 30),
   ('Aplicação de Flúor', 'Prevenção contra cáries com flúor tópico.', 20),
   ('Raspagem Periodontal', 'Limpeza profunda da gengiva e raízes dentárias.', 80);

insert into consulta (id_paciente, id_dentista,data_consulta, status,descricao_atendimento, prescricao)
values (6, 5, '2026-02-01 09:00:00', 'Realizada', 'Paciente realizou avaliação inicial e limpeza.', 'Uso de enxaguante bucal por 7 dias.'),
   (5, 1, '2026-03-02 10:30:00', 'Agendada', NULL, NULL),
   (4, 2, '2026-03-03 14:00:00', 'Realizada', 'Tratamento de canal iniciado no dente 26.', 'Analgésico em caso de dor.'),
   (2, 3, '2026-03-04 11:15:00', 'Cancelada', NULL, NULL),
   (3, 4, '2026-02-05 08:45:00', 'Realizada', 'Aplicação de flúor e avaliação preventiva.', 'Evitar alimentos por 30 minutos.'),
   (1, 6, '2026-03-06 15:00:00', 'Realizada', 'Raspagem periodontal em quadrante superior.', 'Escovação cuidadosa e retorno em 15 dias.'),
   (9, 7, '2026-03-07 16:20:00', 'Agendada', NULL, NULL),
   (10, 8, '2026-03-08 13:10:00', 'Realizada', 'Avaliação para prótese e moldagem inicial.', 'Retorno para prova da prótese.'),
   (7, 9, '2026-01-09 09:40:00', 'Realizada', 'Clareamento dental em consultório.', 'Evitar alimentos com corante por 48 horas.'),
   (8, 10, '2026-03-10 17:00:00', 'Agendada', NULL, NULL);

insert into consulta_procedimento (id_consulta, id_procedimento)
values (1, 8),  
   (1, 1),  
   (2, 7),  
   (3, 3),  
   (4, 6),  
   (5, 8),  
   (5, 9),  
   (6, 10), 
   (7, 4),  
   (8, 8),  
   (9, 5),  
   (10, 8); 

insert into horario_atendimento (id_dentista, dia_semana, hora_inicio, hora_fim)
values (1, 'Segunda', '08:00:00', '12:00:00'),
   (1, 'Quarta', '13:00:00', '18:00:00'),
   (1, 'Sexta', '08:00:00', '12:00:00'),
   (2, 'Terca', '08:00:00', '12:00:00'),
   (2, 'Quinta', '13:00:00', '17:00:00'),
   (2, 'Sabado', '08:00:00', '11:00:00'),
   (3, 'Segunda', '13:00:00', '17:00:00'),
   (3, 'Quarta', '08:00:00', '12:00:00'),
   (4, 'Segunda', '08:00:00', '11:00:00'),
   (4, 'Terca', '14:00:00', '18:00:00'),
   (4, 'Quinta', '08:00:00', '12:00:00'),
   (4, 'Sexta', '14:00:00', '17:00:00'),
   (5, 'Segunda', '08:00:00', '12:00:00'),
   (5, 'Terca', '08:00:00', '12:00:00'),
   (5, 'Quarta', '13:00:00', '18:00:00'),
   (5, 'Quinta', '08:00:00', '12:00:00'),
   (5, 'Sexta', '13:00:00', '17:00:00'),
   (6, 'Terca', '13:00:00', '18:00:00'),
   (6, 'Quarta', '08:00:00', '12:00:00'),
   (6, 'Sexta', '08:00:00', '12:00:00'),
   (7, 'Quinta', '08:00:00', '12:00:00'),
   (7, 'Sexta', '13:00:00', '17:00:00'),
   (8, 'Segunda', '14:00:00', '18:00:00'),
   (8, 'Quarta', '14:00:00', '18:00:00'),
   (8, 'Sabado', '08:00:00', '12:00:00'),
   (9, 'Terca', '09:00:00', '12:00:00'),
   (9, 'Quinta', '14:00:00', '18:00:00'),
   (9, 'Sexta', '09:00:00', '13:00:00'),
   (10, 'Segunda', '09:00:00', '12:00:00'),
   (10, 'Quarta', '09:00:00', '12:00:00'),
   (10, 'Sexta', '14:00:00', '17:00:00');

-- criação dos indices

create index idx_paciente_nome_completo on paciente (nome_completo); -- melhor performance de filtragem da coluna nome completo do paciente

create index idx_horario_atendimento_id_dentista on horario_atendimento (id_dentista); -- melhor performance da listagem de agendamento e na busca de horario do dentista

-- fazendo os updates

update consulta c
set status = 'Cancelada'
where id = 7;

update paciente p
set telefone = '21873456733'
where p.nome_completo = 'Ana Souza Lima';

update procedimento p 
set duracao_media_min = 70
where p.nome = 'Extração';

-- deletando dados

delete from consulta
where status = 'Cancelada';

delete from horario_atendimento
where dia_semana = 'Segunda' and id_dentista = 5;

delete from horario_atendimento 
where dia_semana = 'Sabado';

-- CONSULTAS SQL
-- quantidade de consultas por especialidade

select d.especialidade, count(c.*) as quantidade_consulta
from dentista d
left join consulta c  on d.id = c.id_dentista
group by d.especialidade;

-- quantidade de consultas por dentista

select d.nome_completo, count(c.*) as total_consulta
from dentista d
left join consulta c  on d.id = c.id_dentista
group by d.nome_completo
order by total_consulta desc;

-- pacientes com maior número de consultas

select p.nome_completo , count(c.*) as quantidade_consulta
from paciente p
left join consulta c  on p.id = c.id_paciente
group by p.nome_completo
order by quantidade_consulta desc;

-- VIEW lista de consultas ordenadas por data

create view vw_consultas_ordenadas_por_data as
select
   c.id as "id consulta",
   p.nome_completo as paciente,
   d.nome_completo as dentista,
   c.data_consulta as consulta,
   c.status as status,
   pro.nome as procedimentos
from paciente p
join consulta c
on c.id_paciente = p.id
join dentista d
on d.id = c.id_dentista
left join consulta_procedimento cp
on cp.id_consulta = c.id
left join procedimento pro
on pro.id = cp.id_procedimento
order by data_consulta desc;
	
-- média de consultas por dentista

select d.nome_completo, (
       select avg(contagem_dentista) as media_consulta_dentista
       from (
           	select id_dentista, count(*) as contagem_dentista
           	from consulta
           	group by id_dentista
       )
)
from dentista d;

-- criando query 

--consultas feitas a mais de um mes

select c.data_consulta,
	p.nome_completo as paciente,
	d.nome_completo as dentista,
	proc.descricao,
	c.status
from consulta c 
join paciente p on c.id_paciente = p.id 
join dentista d on c.id_dentista = d.id 
join consulta_procedimento cp on c.id = cp.id_consulta 
join procedimento proc on cp.id_procedimento = proc.id 
where c.status = 'Realizada' and c.data_consulta < current_date - interval '1 month';

--ver as consultas agendadas

select
   c.data_consulta,
   c.status,
   p.nome_completo as paciente,
   d.nome_completo as dentista,
   proc.nome as procedimento_principal,
   proc.duracao_media_min
from consulta c
join paciente p on c.id_paciente = p.id
join dentista d on c.id_dentista = d.id
join consulta_procedimento cp on c.id = cp.id_consulta
join procedimento proc on cp.id_procedimento = proc.id
where c.status = 'Agendada';
	
-- ver historico de consulta do paciente

select p.nome_completo as nome_paciente,
	c.data_consulta,
	c.status,
	d.nome_completo as nome_dentista,
	c.descricao_atendimento
from consulta c
join paciente p on c.id_paciente = p.id
join dentista d on c.id_dentista = d.id
order by c.data_consulta desc;

-- ver cadastros dos pacientes que ja realizaram consultas

select p.nome_completo,
	p.cpf ,p.data_nascimento,
	p.telefone,
	p.email,
	p.endereco,
	c.id_dentista,
	c.data_consulta,
	c.status,
	c.descricao_atendimento,
	c.prescricao
from paciente p
join consulta c on p.id = c.id_paciente 
where c.status ='Realizada';
