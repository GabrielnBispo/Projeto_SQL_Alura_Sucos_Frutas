/* 
1) Vá no item Diagrama de Banco de Dados e clique com o botão da direita do mouse e escolha a opção Novo Diagrama de Banco de Dados.

2) Acesse o SQL Server Management Studio e verifique as tabelas do banco de dados de vendas da empresa de suco de frutas:

3) Existem as tabelas:

TABELA DE VENDEDORES - Lista de vendedores que efetuaram as vendas.
TABELA DE PRODUTOS - Lista dos produtos oferecidos pela empresa.
TABELA DE CLIENTES - Lista de clientes que compram os produtos da empresa.
NOTAS FISCAIS - Notas fiscais das vendas feitas pela empresa.
ITEMS NOTAS FISCAIS - Itens das notas fiscais.

4) Clique onde está o esquema visual e clique no ícone para ancorar a janela.

5) Clique em Nova Consulta e entre com o códigos para fazer consultas
*/

--Para consultar todos os dados de uma tabela:

SELECT * FROM TABELA_DE_CLIENTES;

-- Seleção com filtros:

SELECT CPF, NOME, BAIRRO, CIDADE FROM TABELA_DE_CLIENTES;

-- Seleção com Alias:

SELECT CPF AS IDENTIFICADOR, NOME AS [NOME DE CLIENTE], BAIRRO, CIDADE FROM TABELA_DE_CLIENTES TDC;

--Seleção usando o Alias criado:

SELECT [TDC].[CPF], [TDC].[NOME] FROM [TABELA_DE_CLIENTES] [TDC];

-- Seleção aplicando o filtro where:

SELECT * FROM TABELA_DE_PRODUTOS WHERE CODIGO_DO_PRODUTO = '290478';
SELECT * FROM TABELA_DE_PRODUTOS WHERE SABOR = 'Laranja';
SELECT * FROM TABELA_DE_PRODUTOS WHERE EMBALAGEM = 'PET';
SELECT * FROM TABELA_DE_PRODUTOS WHERE EMBALAGEM = 'pet';
SELECT * FROM TABELA_DE_CLIENTES WHERE IDADE > 20;
SELECT * FROM TABELA_DE_CLIENTES WHERE IDADE <= 18;
SELECT * FROM TABELA_DE_CLIENTES WHERE IDADE <> 18;
SELECT * FROM TABELA_DE_CLIENTES WHERE DATA_DE_NASCIMENTO >= '1995-11-14';
SELECT * FROM TABELA_DE_CLIENTES WHERE BAIRRO >= 'Lapa';

-- Seleção aplicando filtros de expressões lógicas mais complexas:

SELECT * FROM TABELA_DE_PRODUTOS WHERE SABOR = 'Manga' AND TAMANHO = '470 ml';
SELECT * FROM TABELA_DE_PRODUTOS WHERE SABOR = 'Manga' OR TAMANHO = '470 ml';
SELECT * FROM TABELA_DE_PRODUTOS WHERE NOT (SABOR = 'Manga' AND TAMANHO = '470 ml');
SELECT * FROM TABELA_DE_PRODUTOS WHERE NOT (SABOR = 'Manga' OR TAMANHO = '470 ml');
SELECT * FROM TABELA_DE_PRODUTOS WHERE SABOR = 'Manga' OR SABOR = 'Laranja ' OR SABOR = 'Melancia';

SELECT * FROM TABELA_DE_CLIENTES WHERE CIDADE IN ('Rio de Janeiro','Sao Paulo') AND IDADE >= 20;
SELECT * FROM TABELA_DE_CLIENTES WHERE CIDADE IN ('Rio de Janeiro','Sao Paulo') AND (IDADE >= 20 AND IDADE <= 25);
SELECT * FROM TABELA_DE_CLIENTES WHERE CIDADE IN ('Rio de Janeiro','Sao Paulo') AND (IDADE BETWEEN 20 AND 25)

-- Seleção usando LIKE

SELECT * FROM TABELA_DE_PRODUTOS WHERE SABOR LIKE '%Limao';
SELECT * FROM TABELA_DE_PRODUTOS WHERE SABOR LIKE '%Maca%';
SELECT * FROM TABELA_DE_PRODUTOS WHERE SABOR LIKE 'Morango%';
SELECT * FROM TABELA_DE_PRODUTOS WHERE (SABOR LIKE 'Morango%') AND (EMBALAGEM = 'PET');



-- 