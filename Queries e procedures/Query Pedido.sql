
-- NATÁLIA CAMPOS
-- Select dos carros alugados numa data X
SELECT DISTINCT C.placa, C.modelo FROM carro AS C
JOIN pedido AS P
ON C.placa = P.placa
WHERE '2022/02/01' BETWEEN P.data_aluguel AND P.data_retorno;


-- NATÁLIA CAMPOS
-- Select dos carro que não estão alugados na mesma data X
SELECT C.placa, C.modelo FROM carro AS C
JOIN pedido AS P
ON C.placa = P.placa
WHERE '2022/02/01' NOT BETWEEN P.data_aluguel AND P.data_retorno
EXCEPT 
SELECT C.placa, C.modelo FROM carro AS C
JOIN pedido AS P
ON C.placa = P.placa
WHERE '2022/02/01' BETWEEN P.data_aluguel AND P.data_retorno;


-- NATÁLIA CAMPOS
-- Fazer uma função de calcular valor total pedido
CREATE FUNCTION CalculaDiaria(@Placa VARCHAR(7), @Diarias INT)
RETURNS money
BEGIN
   RETURN (SELECT (preco_diaria * @Diarias) FROM carro WHERE placa = @Placa)
END
GO