
Queries Simples
--operadores logicos

--valores  dos carros do Segmento SUV em ordem DESC
SELECT modelo, preco_diaria from carro
WHERE segmento = 'SUV'
ORDER BY preco_diaria DESC

--carros do Segmento Hatch ou Notch
SELECT modelo from carro
WHERE segmento LIKE '%TCH';


-- funções agregadas

--Média do faturamento mensal
SELECT MONTH(data_aluguel) AS Mês, ROUND(CONVERT(NUMERIC(5,0),AVG(valor_total)),0) AS Media_faturamento from pedido
WHERE pedido.data_aluguel BETWEEN '2022-01-01' AND '2022-03-30'
GROUP BY MONTH (pedido.data_aluguel)

--otimização de consultas

--Carros da marca Volkswagen foram alugados na segunda quinzena de fevereiro
SELECT DISTINCT Modelo, Segmento from carro AS car
INNER JOIN pedido AS ped
ON ped.placa = car.placa
WHERE ped.data_aluguel BETWEEN '2022-01-15' AND '2022-02-28'
AND car.Fabricante = 'Volkswagen' AND car.Segmento = 'SUV';

--View

--View pedido vs atendente
CREATE VIEW vw_Pedido_Atendentes
AS SELECT atend.cod_atend, nome_atend  FROM atendente AS atend
INNER JOIN pedido AS ped
ON ped.cod_atendente = atend.cod_atend
INNER JOIN carro AS car
ON ped.placa = car.placa

--consulta view
SELECT*FROM Pedido_Atendentes

