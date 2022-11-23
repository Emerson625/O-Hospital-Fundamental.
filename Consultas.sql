use hospital;

-- Todos os dados e o valor médio das consultas do ano de 2020 e das que foram feitas sob convênio.

select *, AVG(valor_consulta) as 'média dos valores' 
from consulta
where data_consulta like '2020%';

-- Todos os dados das internações que tiveram data de alta maior que a data prevista para a alta.

select * from internação
where data_efetiva_alta > data_prev_alta;

-- Receituário completo da primeira consulta registrada com receituário associado.

SELECT consulta.data_consulta, receita.medico_id, receita.paciente_id, consulta.medico_id, consulta.paciente_id, receita.qnt_medicamentos, receita.instr_medicamentos, receita.medicamentos
FROM receita
inner join consulta
on receita.medico_id = consulta.medico_id and
receita.paciente_id = consulta.paciente_id
where data_consulta like '2015%';

-- Todos os dados da consulta de maior valor e também da de menor valor (ambas as consultas não foram realizadas sob convênio). NÂO QUER IRRR!!!!

SELECT *, Max(valor_consulta), Min(valor_consulta) from consulta where convenio_id is null;

-- Todos os dados das internações em seus respectivos quartos, calculando o total da internação a partir do valor de diária do quarto e o número de dias entre a entrada e a alta.

SELECT internação.id_internacao, quarto.id_quarto, DATEDIFF(data_efetiva_alta, data_entrada) AS uso_de_dias, tipo_quarto.valor_diaria, DATEDIFF(data_efetiva_alta, data_entrada) * tipo_quarto.valor_diaria as valor_total
FROM internação
INNER JOIN quarto 
ON internação.quarto_id = quarto.id_quarto
INNER JOIN tipo_quarto
ON quarto.tipo_quarto = tipo_quarto.id_tipo_quarto
GROUP BY id_internacao;

-- Data, procedimento e número de quarto de internações em quartos do tipo “apartamento”.

 SELECT internação.data_entrada, internação.desc_procedimentos, quarto.numero_quarto
 FROM internação 
 INNER JOIN quarto 
 ON quarto.id_quarto = internação.quarto_id 
 WHERE quarto.tipo_quarto = 2;
 
 -- Nome do paciente, data da consulta e especialidade de todas as consultas em que os pacientes eram menores de 18 anos na data da consulta e cuja especialidade não seja “pediatria”, ordenando por data de realização da consulta.
 
 SELECT paciente.nome_paciente, consulta.data_consulta, especialidade.nome_especialidade
 from consulta
 INNER JOIN paciente
 on consulta.paciente_id = paciente.id_paciente 
 INNER JOIN especialidade
 on consulta.especialidade_id = especialidade.id_especialidade
 where consulta.especialidade_id <> 1 AND YEAR(consulta.data_consulta) - YEAR(paciente.data_nascimento_paciente) < 19 
 AND YEAR(consulta.data_consulta) - YEAR(paciente.data_nascimento_paciente) > 0
 ORDER BY consulta.data_consulta;
 
 -- Nome do paciente, nome do médico, data da internação e procedimentos das internações realizadas por médicos da especialidade “gastroenterologia”, que tenham acontecido em “enfermaria”.
 
 SELECT paciente.nome_paciente, medico.nome_medico, internação.data_entrada, internação.desc_procedimentos, quarto.tipo_quarto
 from internação
 INNER JOIN paciente
 on internação.paciente_id = paciente.id_paciente
 INNER JOIN medico
 on internação.medico_id = medico.id_medico
 INNER JOIN quarto
 on internação.quarto_id = quarto.id_quarto
 where medico.especialidade_id = 3 and quarto.tipo_quarto = 3;
 
 -- Os nomes dos médicos, seus CRMs e a quantidade de consultas que cada um realizou.
 
 SELECT medico.nome_medico, medico.crm, COUNT(consulta.medico_id) as 'qnt de consultas'
 from medico
 INNER JOIN consulta
 on consulta.medico_id = medico.id_medico
 group by consulta.medico_id;
 
 -- Todos os médicos que tenham "Gabriel" no nome. 
 
 SELECT * from medico
 where nome_medico like '%Gabriel%';
 
 -- Os nomes, CREs e número de internações de enfermeiros que participaram de mais de uma internação.
 
 SELECT enfermeiro.nome_enfermeiro, enfermeiro.cre, COUNT(internação.enfermeiro_id) as 'participações'
 from enfermeiro
 INNER JOIN internação
 on internação.enfermeiro_id = enfermeiro.id_enfermeiro
group by internação.enfermeiro_id having participações > 1;

