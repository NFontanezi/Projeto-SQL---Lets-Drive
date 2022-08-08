CREATE TABLE atendente (
cod_atend INT NOT NULL IDENTITY(1,1),
nome_atend VARCHAR(100) NOT NULL,
data_nasc_atend DATE NOT NULL,
conta_salario_atend VARCHAR (15) NOT NULL UNIQUE,
cep_atend VARCHAR(10) NOT NULL,
cidade_atend VARCHAR(40) NOT NULL,
uf_atend CHAR(2) NOT NULL,
rua_atend VARCHAR(100) NOT NULL,
num_resid_atend INT NOT NULL,
salario_atend DECIMAL(7,2) NOT NULL,
comissao_atend DECIMAL(5,2)
PRIMARY KEY (cod_atend)
);





INSERT INTO atendente (nome_atend, data_nasc_atend, conta_salario_atend, cep_atend, cidade_atend, uf_atend, rua_atend, num_resid_atend, complemento_atend, salario_atend, comissao_atend, cpf_atend)
VALUES('Rafael Rocha Dias','1976/09/11','0640987-3','17030-170','Bauru','SP','Rua Manoel da Silva Martha',1319,'Bloco 10',2574.65,0.0625,'480.580.138-70'),
('Larissa Fernandes Pinto','1993/10/30','1336911-9','87705-090','São Paulo','SP','Rua dos Jasmins',827,'',1825.73,0.0625,'057.112.028-80'),
 ('Amanda Fernandes Almeida','1997/08/16','35599820-4','05509-004','São Paulo','SP','Rua Alvarenga',958,'Terreo 4',3451.26,0.0625,'999.102.218-02'),
 ('Kai Cavalcante Souza','1979/09/09','48438769-9','13097-846','Campinas','SP','Rua Seis',925,'',2641.48,0.0625,'897.839.848-02'),
 ('Eduarda Gomes Santos ','1996/10/27','157183-4','07172-410','Guarulhos','SP','Viela Santanópolis',1219,'Quadra 9',1954.85,0.0625,'217.819.708-66'),
 ('Evelyn Sousa Cavalcanti','1994/11/16','122783-1','12943-240','Atibaia','SP','João Umbelino',1119,'',3045.72,0.0625,'702.897.308-56'),
 ('Douglas Lima Araújo','1980/07/29','74047-8','12947-200','Atibaia','SP','Alameda Lorena',413,'Casa 7 ',2976.21,0.0625,'073.650.528-80'),
 ('Pedro Costa Martins','1991/09/29','135946-0','07230-340','Guarulhos','SP','Rua Igarapava',1977,'',3114.57,0.0625,'865.270.148-21'),
 ('Nicolas Cunha Dias','1976/08/20','54450-0','04865-065','São Paulo','SP','Rua Drumond de Andrade',1149,'Fundos 9',2369.98,0.0625,'773.177.908-42'),
 ('Danilo Barbosa Cunha','1995/06/27','1330904-3','05135-400','São Paulo','SP','Rua Adalberto Melo Lucena',1923,'',3296.49,0.0625,'696.880.718-11');
 SELECT * FROM atendente
 DELETE FROM atendente
 DBCC CHECKIDENT(atendente, RESEED,0)

ALTER TABLE atendente
ALTER COLUMN comissao_atend DECIMAL(5,4);

--Ver quantos carros o atendente alugou no mês 

SELECT c.placa,modelo FROM carro as c
INNER JOIN pedido AS p ON c.placa = p.placa
INNER JOIN atendente AS a ON a.cod_atend = p.cod_atendente
WHERE nome_atend = 'Douglas Lima Araújo' AND (p.data_aluguel BETWEEN '2022/03/01' AND '2022/03/31' AND p.data_retorno BETWEEN '2022/03/01' AND '2022/03/31');


--Ver qtos clientes são de x estado

SELECT Nome_Cliente,CPF,Estado FROM cliente
WHERE Estado = 'SP'
GROUP BY Nome_Cliente, CPF, Estado;

SELECT Estado, Count(*) AS total_clientes
FROM cliente
WHERE estado= 'SP'
GROUP BY Estado;


--Ver quantos carros de um modelo X foram alugados em um mês 

SELECT c.placa,c.Modelo,c.Placa FROM carro as c
INNER JOIN pedido as p 
ON c.placa = c.placa
WHERE Modelo = 'Duster' AND '2022/02/01' BETWEEN P.data_aluguel AND P.data_retorno
GROUP BY c.placa,c.modelo;

SELECT Modelo, Count(*) AS total_carros
FROM carro
WHERE Modelo = 'Duster'
GROUP BY Modelo;


--Pega a soma do valor total das diárias que o atendente alugou

GO
CREATE FUNCTION TotalVendido (@cod_atend INT, @data_inicio DATE, @data_final DATE)
RETURNS DECIMAL (7,2)
BEGIN
RETURN (SELECT SUM(valor_total) FROM pedido AS p 
WHERE p.cod_atendente = @cod_atend
AND (p.data_aluguel BETWEEN @data_inicio AND @data_final))
END
GO

SELECT dbo.TotalVendido (1,'2022/01/01','2022/01/31') 


-- Faz o cálculo do salário total do atendente
GO
CREATE FUNCTION CalculaSalario (@cod_atend INT, @salario_atend DECIMAL(7,2), @comissao_atend DECIMAL (5,4), @total_vendido DECIMAL(7,2))
RETURNS DECIMAL (7,2)
BEGIN
   RETURN (SELECT @salario_atend + ( @total_vendido * @comissao_atend) FROM atendente WHERE cod_atend = @cod_atend)
END
GO
SELECT dbo.CalculaSalario (1,2574.65,0.0625,(SELECT dbo.TotalVendido (1,'2022/01/01','2022/01/31'))) AS SALARIO


------------------------PROCEDURE SALARIO TOTAL --------------------
GO
CREATE PROCEDURE SalarioAtendTotal --- Declarando o nome da procedure
@cod_atend INT, @salario_atend DECIMAL(7,2), @comissao_atend DECIMAL (5,4), @total_vendido DECIMAL(7,2)
AS 
BEGIN
DECLARE @SalarioAtendTotal DECIMAL (7,2)
SET @SalarioAtendTotal = dbo.CalculaSalario(@cod_atend, @salario_atend, @comissao_atend, @total_vendido)
SELECT @SalarioAtendTotal AS Salario_Atendente
END
GO

EXECUTE SalarioAtendTotal 1,2574.65,0.0625,2720









