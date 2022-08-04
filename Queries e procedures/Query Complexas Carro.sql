--Queries complexas

-- Procedure
--Consulta valor diaria pelo placa
CREATE PROCEDURE diaria_valor (@placa VARCHAR(7)) 
AS SELECT car.Fabricante, car.Modelo,car.Preco_diaria FROM carro AS car
WHERE car.placa = @placa

EXEC diaria_valor 'EVL4512'


-- TRIGGER
--Consulta valor diaria pelo placa
CREATE TRIGGER msg_after_pedido ON pedido
AFTER INSERT
AS PRINT 'Pedido concluído com sucesso!';


-- Função
--Consulta valor diaria pelo placa
DECLARE @valorTotal MONEY,
		@codAtend INT

SELECT @codAtend = cod_atendente from pedido
SELECT @valorTotal = SUM(valor_total) from pedido
WHERE  cod_atendente = 2 AND MONTH(data_aluguel) = 2

SELECT @codAtend AS 'Atendente',
@valorTotal AS 'Valor Total de Vendas'