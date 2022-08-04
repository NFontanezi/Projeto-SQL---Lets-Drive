--THIAGO COSTA
--17. Criar um procedure que mostra os carros alugados que tem previsão de retorno no dia
CREATE PROCEDURE RetornosDoDia 
@DiaBuscado DATE AS 
	SELECT p.cod_pedido, cl.CPF, ca.Placa, p.data_aluguel, p.data_retorno  FROM pedido p
	JOIN cliente cl ON cl.CPF = p.cpf_cliente
	JOIN carro ca ON ca.placa = p.placa
	WHERE data_retorno = @DiaBuscado

--DROP PROCEDURE RetornosDoDia

EXECUTE RetornosDoDia '2022-03-10'