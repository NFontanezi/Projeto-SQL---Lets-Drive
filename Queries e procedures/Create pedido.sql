CREATE TABLE pedido(
	cod_pedido INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	cod_atendente INT NOT NULL,
	placa VARCHAR(7) NOT NULL,
	cpf_cliente VARCHAR(11) NOT NULL,
	data_aluguel DATE NOT NULL,
	data_retorno DATE NOT NULL,
	diarias INT NOT NULL,
	valor_total	DECIMAL,

	CONSTRAINT FK_cod_atendente
	FOREIGN KEY (cod_atendente)
	REFERENCES atendente(cod_atend),

	CONSTRAINT FK_placa
	FOREIGN KEY (placa)
	REFERENCES carro(placa),

	CONSTRAINT FK_cpf_cliente
	FOREIGN KEY (cpf_cliente)
	REFERENCES cliente(CPF),

);
GO