
-- NAT�LIA CAMPOS
-- Select dos carros alugados numa data X
SELECT DISTINCT C.Cod_carro, C.Modelo, C.Placa FROM carro AS C
JOIN pedido AS P
ON C.Cod_carro = P.cod_carro
WHERE '2022/02/01' BETWEEN P.data_aluguel AND P.data_retorno;


-- NAT�LIA CAMPOS
-- Select dos carro que n�o est�o alugados na mesma data X
SELECT C.Cod_carro, C.Modelo, C.Placa FROM carro AS C
JOIN pedido AS P
ON C.Cod_carro = P.cod_carro
WHERE '2022/02/01' NOT BETWEEN P.data_aluguel AND P.data_retorno
EXCEPT 
SELECT C.Cod_carro, C.Modelo, C.Placa FROM carro AS C
JOIN pedido AS P
ON C.Cod_carro = P.cod_carro
WHERE '2022/02/01' BETWEEN P.data_aluguel AND P.data_retorno;


-- NAT�LIA CAMPOS
-- Fazer uma fun��o de calcular valor total pedido
CREATE FUNCTION CalculaDiaria(@Placa VARCHAR, @Diarias INT)
RETURNS money
BEGIN
   RETURN (SELECT (preco_diaria * @Diarias) FROM carro WHERE placa = @Placa)
END
GO