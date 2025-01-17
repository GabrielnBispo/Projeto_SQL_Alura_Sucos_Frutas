/*
1) Com o SQL Server Management Studio (SSMS) aberto clique no ícone Nova consulta

2) Selecione a base de dados SUCOS_FRUTAS e abra uma nova janela de dados

3) Volte ao esquema que está ancorado
*/

-- Mostre a tabela de vendedores, e depois mostre a tabela de Notas Fiscais:

SELECT * FROM TABELA_DE_VENDEDORES;

SELECT * FROM NOTAS_FISCAIS;

-- Mostre o nome do vendedor fazendo um JOIN entre as tabelas de vendedores e Notas Fiscais:

SELECT NOTAS_FISCAIS.MATRICULA, TABELA_DE_VENDEDORES.NOME, COUNT(*) AS NUMERO_NOTAS 
FROM NOTAS_FISCAIS 
INNER JOIN TABELA_DE_VENDEDORES
ON NOTAS_FISCAIS.MATRICULA = TABELA_DE_VENDEDORES.MATRICULA
GROUP BY  NOTAS_FISCAIS.MATRICULA, TABELA_DE_VENDEDORES.NOME;

--  Substituindo o nome da tabela pelo Alias:

SELECT NF.MATRICULA, TV.NOME, COUNT(*) AS NUMERO_NOTAS 
FROM NOTAS_FISCAIS NF
INNER JOIN TABELA_DE_VENDEDORES TV
ON NF.MATRICULA = TV.MATRICULA
GROUP BY  NF.MATRICULA, TV.NOME;

-- Usando o JOIN nas tabela de clientes e notas fiscais usando CPF:

SELECT 
TC.CPF AS CPF_DO_CADASTRO
, TC.NOME AS NOME_DO_CLIENTE
, NF.CPF AS CPF_DA_NOTA
FROM TABELA_DE_CLIENTES TC
INNER JOIN
NOTAS_FISCAIS NF
ON TC.CPF = NF.CPF

-- Usando o DISTINCT para mostrar os clientes que compraram:

SELECT DISTINCT
TC.CPF AS CPF_DO_CADASTRO
, TC.NOME AS NOME_DO_CLIENTE
, NF.CPF AS CPF_DA_NOTA
FROM TABELA_DE_CLIENTES TC
INNER JOIN
NOTAS_FISCAIS NF
ON TC.CPF = NF.CPF

-- Inserindo um novo cliente na tabela:

INSERT INTO TABELA_DE_CLIENTES
(CPF, NOME, ENDERECO_1, ENDERECO_2, BAIRRO, CIDADE, ESTADO, CEP, DATA_DE_NASCIMENTO, IDADE,
GENERO, LIMITE_DE_CREDITO, VOLUME_DE_COMPRA, PRIMEIRA_COMPRA)
VALUES ('23412632331', 'Juliana Silva', 'R. Tramandai','','Bangu','Rio de Janeiro','RJ','23400000',
'1989-02-04',33,'F',180000,24500, 0);

-- Mostre quantos clientes cadastrados na tabela e quantos compraram:

SELECT COUNT(*) FROM TABELA_DE_CLIENTES;

SELECT DISTINCT
TC.CPF AS CPF_DO_CADASTRO
, TC.NOME AS NOME_DO_CLIENTE
, NF.CPF AS CPF_DA_NOTA
FROM TABELA_DE_CLIENTES TC
INNER JOIN
NOTAS_FISCAIS NF
ON TC.CPF = NF.CPF

-- Usando o LEFT JOIN para mostrar os clientes

SELECT DISTINCT
TC.CPF AS CPF_DO_CADASTRO
, TC.NOME AS NOME_DO_CLIENTE
, NF.CPF AS CPF_DA_NOTA
FROM TABELA_DE_CLIENTES TC 
LEFT JOIN 
NOTAS_FISCAIS NF
ON TC.CPF = NF.CPF

-- Mostre qual cliente não fez venda usando o LEFT JOIN e o filtro WHERE:

SELECT DISTINCT
TC.CPF AS CPF_DO_CADASTRO
, TC.NOME AS NOME_DO_CLIENTE
FROM TABELA_DE_CLIENTES TC 
LEFT JOIN 
NOTAS_FISCAIS NF
ON TC.CPF = NF.CPF
WHERE NF.CPF IS NULL

-- Mostre os preços médios das embalagens:

SELECT EMBALAGEM, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO
FROM TABELA_DE_PRODUTOS GROUP BY EMBALAGEM;

-- Usando HAVING para mostrar somente as embalagens com preços menores que 10:

SELECT EMBALAGEM, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO
FROM TABELA_DE_PRODUTOS GROUP BY EMBALAGEM
HAVING AVG(PRECO_DE_LISTA) <= 10;

-- Usando uma sub query:

SELECT MEDIA_EMBALAGENS.EMBALAGEM, 
MEDIA_EMBALAGENS.PRECO_MEDIO FROM
(SELECT EMBALAGEM, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO
FROM TABELA_DE_PRODUTOS GROUP BY EMBALAGEM) MEDIA_EMBALAGENS
WHERE MEDIA_EMBALAGENS.PRECO_MEDIO <= 10;



