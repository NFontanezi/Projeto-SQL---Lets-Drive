--THIAGO COSTA
--16. Criar um procedure que mostra os alugueis efetuados no dia
CREATE PROCEDURE AlugueisDoDia 
@DiaBuscado DATE AS 
	SELECT p.cod_pedido, cl.CPF, ca.Placa, p.data_aluguel, p.data_retorno  FROM pedido p
	JOIN cliente cl ON cl.CPF = p.cpf_cliente
	JOIN carro ca ON ca.Placa = p.placa
	WHERE data_aluguel = @DiaBuscado

EXECUTE AlugueisDoDia '2022-03-09'