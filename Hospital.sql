
use hospital;

CREATE table if not exists convenio (
id_convenio int(11) auto_increment primary key,
nome_convenio varchar(100) not null,
tempo_carencia varchar(255) not null,
cnpj_convenio varchar(14) unique not null
);

CREATE table if not exists paciente (
id_paciente int(11) auto_increment primary key,
rg_paciente varchar(15) unique not null,
cpf_paciente varchar(255) unique not null,
nome_paciente varchar(100) not null,
data_nascimento_paciente date not null,
email_paciente varchar(255) unique not null,
endereço_paciente varchar(255) not null,
convenio_id int(11) default null,
foreign key(convenio_id) references convenio (id_convenio) on delete cascade on update cascade,
telefone_paciente varchar(18)
);

CREATE table if not exists consulta (
id_consulta int(11) auto_increment primary key,
valor_consulta decimal not null,
data_consulta date not null,
hora_consulta time not null,
convenio_id int (11) default null,
foreign key (convenio_id) references convenio (id_convenio) on delete cascade on update cascade,
paciente_id int(11) not null,
foreign key (paciente_id) references paciente (id_paciente) on delete cascade on update cascade,
medico_id int (11) not null,
foreign key (medico_id) references medico (id_medico) on delete cascade on update cascade,
especialidade_id int(11) not null,
foreign key (especialidade_id) references especialidade (id_especialidade) on delete cascade on update cascade
);

CREATE table if not exists medico(
id_medico int (11) auto_increment primary key,
nome_medico varchar(100) not null,
cpf_medico varchar(15) unique not null,
crm varchar (11) unique not null,
email_medico varchar(255) unique not null,
telefone_medico varchar(15) not null,
especialidade_id int (11) not null,
foreign key (especialidade_id) references especialidade (id_especialidade) on delete cascade on update cascade,
cargo_id int(11) not null,
foreign key (cargo_id) references cargo (id_cargo) on delete cascade on update cascade
);

CREATE table if not exists especialidade(
id_especialidade int (11) auto_increment primary key,
nome_especialidade varchar(100) not null
);

CREATE table if not exists cargo(
id_cargo int (11) auto_increment primary key,
nome_cargo varchar(100) not null
);


CREATE table if not exists receita (
id_receita int (11) auto_increment primary key,
qnt_medicamentos varchar (505) not null,
instr_medicamentos varchar (505) not null,
medicamentos varchar (255) not null,
medico_id int (11) not null,
foreign key (medico_id) references medico (id_medico) on delete cascade on update cascade,
paciente_id int (11) not null,
foreign key (paciente_id) references paciente (id_paciente) on delete cascade on update cascade
);

CREATE table if not exists internação (
id_internacao int (11) auto_increment primary key,
data_efetiva_alta date not null,
data_prev_alta date not null,
data_entrada date not null,
desc_procedimentos text,
medico_id int (11) not null,
paciente_id int (11) not null,
enfermeiro_id int(11) not null,
enfermeiro2 int null,
quarto_id int (11) not null,
foreign key (enfermeiro2) references enfermeiro (id_enfermeiro) on delete cascade on update cascade,
foreign key (quarto_id) references quarto (id_quarto) on delete cascade on update cascade,
foreign key (medico_id) references medico (id_medico) on delete cascade on update cascade,
foreign key (paciente_id) references paciente (id_paciente) on delete cascade on update cascade,
foreign key (enfermeiro_id) references enfermeiro (id_enfermeiro) on delete cascade on update cascade
);

CREATE table if not exists enfermeiro (
id_enfermeiro int (11) auto_increment primary key,
nome_enfermeiro varchar (100) not null,
cre varchar (13) unique not null,
cpf_enfermeiro varchar (15) unique not null 
);

CREATE table if not exists quarto(
id_quarto int (11) auto_increment primary key,
numero_quarto varchar (100) not null,
tipo_quarto int (11) not null,
foreign key (tipo_quarto) references tipo_quarto (id_tipo_quarto) on update cascade on delete cascade
);

CREATE table if not exists tipo_quarto (
id_tipo_quarto int (11) auto_increment primary key,
valor_diaria decimal not null,
tipo_quarto varchar (100) not null
);

-- Adicionando cargos

INSERT INTO cargo (id_cargo, nome_cargo) values(1, "generalista");
INSERT INTO cargo (id_cargo, nome_cargo) values(2, "especialista");
INSERT INTO cargo (id_cargo, nome_cargo) values(3, "residente");

-- Adicionando convênios

INSERT into convenio (id_convenio, nome_convenio, tempo_carencia, cnpj_convenio) values(1, 'Alice', '6 meses', '342665530001');
INSERT into convenio (id_convenio, nome_convenio, tempo_carencia, cnpj_convenio) values(2, 'Vida V', 'Isento de carência', '26738894000105');
INSERT into convenio (id_convenio, nome_convenio, tempo_carencia, cnpj_convenio) values(3, 'Unimed', '180 dias', '02812468000106');
INSERT into convenio (id_convenio, nome_convenio, tempo_carencia, cnpj_convenio) values(4, 'Unisp', '24 horas', '02815438000103');

-- Adicionando especialidades

INSERT INTO especialidade (id_especialidade, nome_especialidade) values(1, "pediatria");
INSERT INTO especialidade (id_especialidade, nome_especialidade) values(2, "clínica_geral");
INSERT INTO especialidade (id_especialidade, nome_especialidade) values(3, "gastroenterologia");
INSERT INTO especialidade (id_especialidade, nome_especialidade) values(4, "dermatologia");

-- Adicionando médicos

INSERT into medico (id_medico, nome_medico, cpf_medico, crm, email_medico, telefone_medico, especialidade_id, cargo_id) values (1, "Carlos Alberto",  24568923112, "SP 123456", "re1972@coinecon.com", 11612347887, 1, 1);
INSERT into medico (id_medico, nome_medico, cpf_medico, crm, email_medico, telefone_medico, especialidade_id, cargo_id) values (2, "Michael Jackson",  32562323112, "MG 456456", "michael2@coinecon.com", 11232347887, 2, 3);
INSERT into medico (id_medico, nome_medico, cpf_medico, crm, email_medico, telefone_medico, especialidade_id, cargo_id) values (3, "Michael B. Jordan",  94562743112, "BA 653456", "beaultifulman@coinecon.com", 11212737887, 4, 2);
INSERT into medico (id_medico, nome_medico, cpf_medico, crm, email_medico, telefone_medico, especialidade_id, cargo_id) values (4, "Debora Fonseca",  24578923462, "SP 097226", "fonseca@coinecon.com", 11863343457, 2, 2);
INSERT into medico (id_medico, nome_medico, cpf_medico, crm, email_medico, telefone_medico, especialidade_id, cargo_id) values (5, "Homer Simpson", 54666671212, "SP 447856", "homer200@coinecon.com", 172637887, 4, 3);
INSERT into medico (id_medico, nome_medico, cpf_medico, crm, email_medico, telefone_medico, especialidade_id, cargo_id) values (6, "Michael Jordan",  12362743112, "PE 122710", "basketballplayer@coinecon.com", 11093102887, 1, 3);
INSERT into medico (id_medico, nome_medico, cpf_medico, crm, email_medico, telefone_medico, especialidade_id, cargo_id) values (7, "Claudia Pires",  24562839412, "RJ 847456", "pires2929@coinecon.com", 11610832887, 2, 2);
INSERT into medico (id_medico, nome_medico, cpf_medico, crm, email_medico, telefone_medico, especialidade_id, cargo_id) values (8, "Gustavo Lima",  32947382112, "MG 455637", "liminha@coinecon.com", 11874347887, 3, 1);
INSERT into medico (id_medico, nome_medico, cpf_medico, crm, email_medico, telefone_medico, especialidade_id, cargo_id) values (9, "Ewerton Santos",  94167283982, "ES 126637", "vegeta123r563@coinecon.com", 11962124453, 2, 1);
INSERT into medico (id_medico, nome_medico, cpf_medico, crm, email_medico, telefone_medico, especialidade_id, cargo_id) values (10, "Lionel Messi",  24512311211, "AM 443356", "thebest@coinecon.com", 11961249884, 2, 3);

-- Adicionando pacientes

INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (1, '556582263', '53216362731', 'Emerson Sheik', '2001-10-17', 'sheik22@gmail.com', 'Rua Ana Maria, 325, Rio Pequeno', 1, '11893223456');
INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (2, '512582263', '56832162731', 'Silvester Stalone', '1976-10-17', 'RockyBalboa@gmail.com', 'Rua do Canalha, 14, Bairro da Moscas', 3, '11893263745');
INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (3, '556512263', '56826362311', 'Edilson Santos', '1999-10-17', 'www.Edilson@gmail.com', 'Rua da Cenoura, 25, Butantã', 2, '11898736553');
INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (4, '512581263', '53216122731', 'Maria Lúcia', '1992-10-17', 'LuciaMah68@gmail.com', 'Rua do Alho, 32, Rio Médio', null, '11123676128');
INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (5, '556582123', '56826332131', 'Maria Marlene', '2004-10-17', 'marlene22@gmail.com', 'Rua de Não te interessa, 375, Rio Grande', 1, '11893127890');
INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (6, '673843321', '89201923465', 'Elon Musk', '1997-5-3', 'Rich2022@gmail.com', 'Rua Augusto de Motta, 23, Carueno', 1, '11893223872');
INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (7, '662789034', '21345678293', 'Tobey Maguire', '1982-1-22', 'SpiderMan@gmail.com', 'Rua do Biricotico, 876, Bairro dos Bebados', 3, '11986663745');
INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (8, '556102923', '23415678923', 'Milena White', '2007-6-23', 'LilDog@gmail.com', 'Rua do Arroz, 725, Sapé', 2, '11893847563');
INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (9, '536748901', '12376890090', 'George Bush', '1990-12-5', 'President@gmail.com', 'Rua do Alho, 32, Rio Médio', null, '11123676128');
INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (10, '652839045', '56798212374', 'Leon S. Kennedy', '2000-7-7', 'Resident4@gmail.com', 'Rua dos Jogos, 1000, Bom Retiro', 2, '11890985670');
INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (11, '932502123', '87430921345', 'Lucivânia Leitão', '2001-11-07', 'TheBestMom@gmail.com', 'Rua do Feijão, 525, Rio Gigantesco', 2, '11964738992');
INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (12, '109230101', '09475832123', 'Mike Tyson', '1976-4-24', 'BoxFighter@gmail.com', 'Rua do Maumau, 111, Bairro da Estranheza', null, '11899854745');
INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (13, '234561782', '98463523456', 'Taylor Swift', '1999-6-7', 'SingerWoman@gmail.com', 'Rua da Alegria, 125, Jardins', 1, '11887623456');
INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (14, '517289034', '12687332123', 'Rosaria dos Santos', '1992-8-1', 'MulherPolitica@gmail.com', 'Rua da Brasilia, 245, Senado Verde', null, '11236676128');
INSERT into paciente (id_paciente, rg_paciente, cpf_paciente, nome_paciente, data_nascimento_paciente, email_paciente, endereço_paciente, convenio_id, telefone_paciente) values (15, '901234567', '8907678342', 'Abraham Lincon', '2002-2-15', 'BigBeard@gmail.com', 'Rua da História, 3, New York', null, '11854627890');

-- Adicionando Consultas

INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(1, '200.00', '2015-01-01', '09:45:00', 1,1,1,1); -- repete
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(2, '250.00', '2016-11-21', '09:45:00', 1,6,8,3); 
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(3, '300.00', '2017-10-30', '19:45:00', null,14,3,4); -- repete
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(4, '750.00', '2018-06-27', '11:30:00', 1,5,4,2);
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(5, '150.00', '2019-05-25', '13:00:00', null,9,8,3);
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(6, '325.00', '2020-08-01', '08:30:00', null,15,9,2);
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(7, '70.00', '2021-11-08', '09:00:00', 3,2,10,2);
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(8, '400.00', '2022-12-02', '07:45:00', 2,3,7,2);
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(9, '270.00', '2015-02-01', '11:15:00', 1,1,1,1); 
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(10, '120.00', '2016-09-19', '15:00:00', null,4,6,1);
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(11, '310.00', '2017-04-02', '18:30:00', 3,7,5,4);
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(12, '180.50', '2018-07-22', '11:15:00', 2,8,1,1);
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(13, '125.00', '2019-02-19', '09:25:00', 2,10,7,2);
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(14, '1000.00', '2020-11-13', '12:40:00', 2,11,8,3);
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(15, '120.00', '2021-06-17', '11:10:00', null,12,3,4);
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(16, '278.00', '2022-02-28', '08:00:00', 1,13,9,2);
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(17, '100.00', '2015-01-03', '13:30:00', 1,15,9,2);
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(18, '478.00', '2016-04-09', '14:00:00', null,14,3,4); 
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(19, '500.00', '2017-09-12', '17:00:00', null,12,1,1);
INSERT into consulta (id_consulta, valor_consulta, data_consulta, hora_consulta, convenio_id, paciente_id, medico_id, especialidade_id) values(20, '60.00', '2018-10-02', '09:00:00', 2,8,7,2);


-- Adicionando enfermeiro

INSERT into enfermeiro (id_enfermeiro, nome_enfermeiro, cre, cpf_enfermeiro) values(1, 'Cláudio Augusto', '672938', '67921087528');
INSERT into enfermeiro (id_enfermeiro, nome_enfermeiro, cre, cpf_enfermeiro) values(2, 'Maria Antonieta', '982128', '01876087527');
INSERT into enfermeiro (id_enfermeiro, nome_enfermeiro, cre, cpf_enfermeiro) values(3, 'Lucão de Almeida', '609378', '27998022225');
INSERT into enfermeiro (id_enfermeiro, nome_enfermeiro, cre, cpf_enfermeiro) values(4, 'Cláudio Augusto', '698293', '19809389894');
INSERT into enfermeiro (id_enfermeiro, nome_enfermeiro, cre, cpf_enfermeiro) values(5, 'Hernandes Dias', '922993', '67909883524');
INSERT into enfermeiro (id_enfermeiro, nome_enfermeiro, cre, cpf_enfermeiro) values(6, 'John MacArthur', '900298', '01871728921');
INSERT into enfermeiro (id_enfermeiro, nome_enfermeiro, cre, cpf_enfermeiro) values(7, 'Sarah Plant', '609278', '20948020338');
INSERT into enfermeiro (id_enfermeiro, nome_enfermeiro, cre, cpf_enfermeiro) values(8, 'Arthur Morgan', '092293', '59800949891');
INSERT into enfermeiro (id_enfermeiro, nome_enfermeiro, cre, cpf_enfermeiro) values(9, 'Oseias Beeri', '567389', '67901094526');
INSERT into enfermeiro (id_enfermeiro, nome_enfermeiro, cre, cpf_enfermeiro) values(10, 'Elias Pardo', '560079', '67289102834');

-- adicionando quartos 

INSERT into quarto (id_quarto, numero_quarto, tipo_quarto) values (1, '337', 1);
INSERT into quarto (id_quarto, numero_quarto, tipo_quarto) values (2, '7', 3);
INSERT into quarto (id_quarto, numero_quarto, tipo_quarto) values (3, '114', 2);
INSERT into quarto (id_quarto, numero_quarto, tipo_quarto) values (4, '115', 2);
INSERT into quarto (id_quarto, numero_quarto, tipo_quarto) values (5, '338', 1);
INSERT into quarto (id_quarto, numero_quarto, tipo_quarto) values (6, '8', 3);

-- adicionando o tipo dos quartos

INSERT into tipo_quarto(id_tipo_quarto, valor_diaria, tipo_quarto) values (1, '450.00', 'quarto duplo');
INSERT into tipo_quarto(id_tipo_quarto, valor_diaria, tipo_quarto) values (2, '950.00', 'apartamento');
INSERT into tipo_quarto(id_tipo_quarto, valor_diaria, tipo_quarto) values (3, '700.00', 'enfermaria');

-- adicionando internações

INSERT into internação (id_internacao, data_efetiva_alta, data_prev_alta, desc_procedimentos, data_entrada, medico_id, paciente_id, enfermeiro_id, quarto_id ) values (1, '2015-01-10', '2015-01-08', 'Drenagem Torácica. Inserção de um tubo na cavidade pleural, para drenagem do sangue.','2015-01-02', 1, 1, 1, 2, 1);
INSERT into internação (id_internacao, data_efetiva_alta, data_prev_alta, desc_procedimentos, data_entrada, medico_id, paciente_id, enfermeiro_id, quarto_id ) values (2, '2015-02-10', '2015-02-08', 'Drenagem Torácica. Inserção de um tubo na cavidade pleural, para drenagem do sangue.','2015-02-01', 1, 1, 1, 3, 2);
INSERT into internação (id_internacao, data_efetiva_alta, data_prev_alta, desc_procedimentos, data_entrada, medico_id, paciente_id, enfermeiro_id, quarto_id ) values (3, '2017-11-01', '2017-11-03', 'Inserção de um cateter agulhado pela membrana cricotireoidea','2017-10-31', 3, 14, 8, 4, 6);
INSERT into internação (id_internacao, data_efetiva_alta, data_prev_alta, desc_procedimentos, data_entrada, medico_id, paciente_id, enfermeiro_id, quarto_id ) values (4, '2017-11-18', '2017-11-20', 'Inserção de um cateter para retirar pus.','2017-11-02', 3, 14, 7, 6, 6);
INSERT into internação (id_internacao, data_efetiva_alta, data_prev_alta, desc_procedimentos, data_entrada, medico_id, paciente_id, enfermeiro_id, quarto_id ) values (5, '2017-04-05', '2017-04-04', 'Cirurgia para hérnia umbilical.','2017-04-02', 5, 7, 10, 3, 5);
INSERT into internação (id_internacao, data_efetiva_alta, data_prev_alta, desc_procedimentos, data_entrada, medico_id, paciente_id, enfermeiro_id, quarto_id ) values (6, '2019-01-10', '2019-01-13', 'Tratamento de quimioterapia','2019-01-12', 8, 11, 8, 7, 2);
INSERT into internação (id_internacao, data_efetiva_alta, data_prev_alta, desc_procedimentos, data_entrada, medico_id, paciente_id, enfermeiro_id, quarto_id ) values (7, '2022-10-18', '2022-10-17', 'Administração de medicamentos de pressão para a melhora do paciente','2022-10-17', 8, 12, 4, 9, 3);

-- Adicionando receitas

INSERT into receita (id_receita, qnt_medicamentos, instr_medicamentos, medicamentos, medico_id, paciente_id) values (1, '25 cápsulas', 'Aplicar na área das entradas do cabelo 2 vezes ao dia', 'Minoxidil', 8, 6); 
INSERT into receita (id_receita, qnt_medicamentos, instr_medicamentos, medicamentos, medico_id, paciente_id) values (2, '30 cápsulas', 'Tomar uma cápsula ao dia', 'Arodais 50mg', 7, 3);
INSERT into receita (id_receita, qnt_medicamentos, instr_medicamentos, medicamentos, medico_id, paciente_id) values (3, '1,5 ml', 'Aplicação deve ser feita uma vez ao dia', 'Jardiance 25mg', 6, 4);
INSERT into receita (id_receita, qnt_medicamentos, instr_medicamentos, medicamentos, medico_id, paciente_id) values (4, 'Caixa com 4 comprimidos revestidos', 'Aplicar na área das entradas do cabelo 2 vezes ao dia', 'Citrato de Sildenafila Neo Química 50mg', 10, 2);
INSERT into receita (id_receita, qnt_medicamentos, instr_medicamentos, medicamentos, medico_id, paciente_id) values (5, 'Uma caixa com 30 comprimidos revestidos', 'Devem ser ingeridos inteiros, uma vez ao dia, por via oral, com água, a qualquer hora do dia, com ou sem alimentos.', 'Rosuvastatina Cálcica Sandoz 10mg', 8, 11);
INSERT into receita (id_receita, qnt_medicamentos, instr_medicamentos, medicamentos, medico_id, paciente_id) values (6, 'Uma caixa com 30 comprimidos', 'Tomar os comprimidos com líquido, por via oral', 'Ciprofibrato Biolab Genéricos 100mg', 3, 14);
INSERT into receita (id_receita, qnt_medicamentos, instr_medicamentos, medicamentos, medico_id, paciente_id) values (7, 'Uma caixa com 30 comprimidos revestidos', 'Ingerir 2 cápsulas ao dia a qualquer momento', 'Atorvastatina Cálcica Nova Química 20mg', 1, 12);
INSERT into receita (id_receita, qnt_medicamentos, instr_medicamentos, medicamentos, medico_id, paciente_id) values (8, 'Uma caixa com 1 frasco-ampola com pó para solução de uso intravenoso + 1 frasco-ampola com 10mL de solução estabilizante', 'Aplicar na área das entradas do cabelo 2 vezes ao dia', 'Blincyto 38,5mcg', 7, 8);
INSERT into receita (id_receita, qnt_medicamentos, instr_medicamentos, medicamentos, medico_id, paciente_id) values (9, 'Uma caixa com 1 frasco com 100mL de solução de uso intravenoso', 'Aplicar na área das entradas do cabelo 2 vezes ao dia', 'Aclasta 5mg/100mL', 9, 15);
INSERT into receita (id_receita, qnt_medicamentos, instr_medicamentos, medicamentos, medico_id, paciente_id) values (10, 'caixa com 1 frasco-ampola', 'Aplicar na área das entradas do cabelo 2 vezes ao dia', 'Botulim 100U', 4, 5);
