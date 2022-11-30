BEGIN TRANSACTION

CREATE TABLE Cliente
(
  Codigo INT IDENTITY (1,1) NOT NULL,
  CPF CHAR(11) NOT NULL,
  Nome VARCHAR(40),
  Email VARCHAR(40),
  Telefone CHAR(11),
  Celular CHAR(11),
  CEP CHAR(8),
  Logadouro VARCHAR(40),
  Estado CHAR(2),
  Cidade VARCHAR(35),

  
  CONSTRAINT PK_CodigoCliente PRIMARY KEY (Codigo)
)

CREATE TABLE Fidelidade
(
  CodigoCliente INT,
  DataAdesao DATETIME NOT NULL,
  Pontos INT,

  CONSTRAINT PK_CodigoClienteFidelidade PRIMARY KEY (CodigoCliente),
  CONSTRAINT FK_CodigoCliente_Fidelidade FOREIGN KEY (CodigoCliente) REFERENCES Cliente(Codigo)
)

CREATE TABLE FormaPagamento
(
  Codigo INT IDENTITY (1,1) NOT NULL,
  Nome VARCHAR(25), 
  Tipo VARCHAR(25),

  CONSTRAINT PK_CodigoPagamento PRIMARY KEY (Codigo)
)

CREATE TABLE Marca
(
  Codigo INT IDENTITY (1,1) NOT NULL,
  Nome VARCHAR(20),
  Empresa VARCHAR(30),

  CONSTRAINT PK_CodigoMarca PRIMARY KEY (Codigo)
)

CREATE TABLE Produto 
(
  Codigo INT IDENTITY (1,1) NOT NULL,
  Nome VARCHAR(30),
  Descricao VARCHAR(MAX),
  CodigoMarca INT NOT NULL,

  CONSTRAINT PK_CodigoProduto PRIMARY KEY (Codigo),
  CONSTRAINT FK_CodigoMarca FOREIGN KEY (CodigoMarca) REFERENCES Marca(Codigo)
)

CREATE TABLE PedidoVenda
(
  Codigo INT IDENTITY (1,1) NOT NULL,
  Valor DECIMAL(6,2),
  Imposto DECIMAL(6,2),
  DataVenda DATETIME NOT NULL,
  CodigoFormaPagamento INT NOT NULL,
  CodigoCliente INT NOT NULL,

  CONSTRAINT PK_CodigoVenda PRIMARY KEY (Codigo),
  CONSTRAINT FK_CodigoFormaPagamento FOREIGN KEY (CodigoFormaPagamento) REFERENCES FormaPagamento(Codigo)
)

CREATE TABLE ItemPedidoVenda
(
  Codigo INT IDENTITY (1,1) NOT NULL,
  ValorTotal DECIMAL(6,2),
  ValorImposto DECIMAL(6,2),
  ValorUnitario DECIMAL(6,2),
  Quantidade INT,
  CodigoProduto INT NOT NULL,
  CodigoPedidoVenda INT NOT NULL,

  CONSTRAINT PK_CodigoPedidoVenda PRIMARY KEY (Codigo),
  CONSTRAINT FK_CodigoProdutoVenda FOREIGN KEY (CodigoProduto) REFERENCES Produto(Codigo),
  CONSTRAINT FK_CodigoVenda FOREIGN KEY (CodigoPedidoVenda) REFERENCES PedidoVenda(Codigo)
)

CREATE TABLE Distribuidor
(
  Codigo INT IDENTITY (1,1) NOT NULL,
  CNPJ VARCHAR(14) NOT NULL,
  NomeFantasia VARCHAR(40) NOT NULL,
  RazaoSocial VARCHAR(40) NOT NULL,
  CEP NCHAR(8),
  Logadouro VARCHAR(40),
  Estado CHAR(2),
  Cidade VARCHAR(35),

  CONSTRAINT PK_CodigoDistribuidor PRIMARY KEY (Codigo)
)

CREATE TABLE PedidoCompra
(
  Codigo INT IDENTITY(1,1) NOT NULL,
  DataCompra DATETIME NOT NULL,
  Valor DECIMAL(6,2),
  Entregue BIT, 
  CodigoDistribuidor INT NOT NULL,

  CONSTRAINT PK_CodigoPedidoVenda PRIMARY KEY (Codigo),
  CONSTRAINT FK_CodigoDistribuidor FOREIGN KEY (CodigoDistribuidor) REFERENCES Distriuidor(Codigo)
)

CREATE TABLE ItemPedidoCompra
(
  Codigo INT IDENTITY(1,1) NOT NULL,
  ValorTotal DECIMAL(6,2),
  ValorUnitario DECIMAL(6,2),
  Quantidade INT,
  CodigoProduto INT NOT NULL,
  CodigoPedidoCompra INT NOT NULL,

  CONSTRAINT PK_CodigoItemPedidoVenda PRIMARY KEY (Codigo),
  CONSTRAINT FK_CodigoProdutoCompra FOREIGN KEY (CodigoProduto) REFERENCES Produto(Codigo),
  CONSTRAINT FK_CodigoPedidoCompraItem FOREIGN KEY (CodigoPedidoCompra) REFERENCES PedidoCompra(Codigo)
)

COMMIT

--ROLLBACK