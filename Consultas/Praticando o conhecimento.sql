/*
Praticando o conhecimento:
*/

-- Calcule o volume da venda por cliente:

SELECT 
NF.CPF
,NF.DATA_VENDA
,INF.QUANTIDADE
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO

--Calcule a mesma informação dentro do mês e do ano:

SELECT 
NF.CPF
,CONVERT(VARCHAR(7), NF.DATA_VENDA, 120) AS MES_ANO
,INF.QUANTIDADE
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO

-- Agrupe por CPF:

SELECT 
NF.CPF
,CONVERT(VARCHAR(7), NF.DATA_VENDA, 120) AS MES_ANO
,SUM(INF.QUANTIDADE) AS QUANTIDADE_TOTAL
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
GROUP BY
NF.CPF
, CONVERT(VARCHAR(7), NF.DATA_VENDA, 120)

-- Compare o volume de compra com o volume total por CPF:

SELECT
TC.CPF, TC.NOME, TC.VOLUME_DE_COMPRA, TV.MES_ANO, TV.QUANTIDADE_TOTAL
FROM TABELA_DE_CLIENTES TC
INNER JOIN
(
SELECT 
NF.CPF
,CONVERT(VARCHAR(7), NF.DATA_VENDA, 120) AS MES_ANO
,SUM(INF.QUANTIDADE) AS QUANTIDADE_TOTAL
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
GROUP BY
NF.CPF
, CONVERT(VARCHAR(7), NF.DATA_VENDA, 120)
) TV
ON TV.CPF = TC.CPF

-- Vamos classificar o volume para descobrir o que estiver fora do limite:

SELECT
TC.CPF, TC.NOME, TC.VOLUME_DE_COMPRA, TV.MES_ANO, TV.QUANTIDADE_TOTAL,
(CASE WHEN TC.VOLUME_DE_COMPRA >= TV.QUANTIDADE_TOTAL THEN 'VENDAS VÁLIDAS'
ELSE 'VENDAS INVÁLIDAS' END) AS RESULTADO
FROM TABELA_DE_CLIENTES TC
INNER JOIN
(
SELECT 
NF.CPF
,CONVERT(VARCHAR(7), NF.DATA_VENDA, 120) AS MES_ANO
,SUM(INF.QUANTIDADE) AS QUANTIDADE_TOTAL
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
GROUP BY
NF.CPF
, CONVERT(VARCHAR(7), NF.DATA_VENDA, 120)
) TV
ON TV.CPF = TC.CPF

-- Agora vamos filtrar por data

SELECT
TC.CPF, TC.NOME, TC.VOLUME_DE_COMPRA, TV.MES_ANO, TV.QUANTIDADE_TOTAL,
(CASE WHEN TC.VOLUME_DE_COMPRA >= TV.QUANTIDADE_TOTAL THEN 'VENDAS VÁLIDAS'
ELSE 'VENDAS INVÁLIDAS' END) AS RESULTADO
FROM TABELA_DE_CLIENTES TC
INNER JOIN
(
SELECT 
NF.CPF
,CONVERT(VARCHAR(7), NF.DATA_VENDA, 120) AS MES_ANO
,SUM(INF.QUANTIDADE) AS QUANTIDADE_TOTAL
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
GROUP BY
NF.CPF
, CONVERT(VARCHAR(7), NF.DATA_VENDA, 120)
) TV
ON TV.CPF = TC.CPF
WHERE TV.MES_ANO = '2015-01'

-- Quantas vendas foram feitas por sabor?

SELECT
TP.SABOR
,NF.DATA_VENDA
,INF.QUANTIDADE
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO

-- Agrupe por ano:

SELECT
TP.SABOR
,YEAR(NF.DATA_VENDA) AS ANO
,SUM(INF.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)

-- Filtre para um ano específico com as vendas ordenadas:

SELECT
TP.SABOR
,YEAR(NF.DATA_VENDA) AS ANO
,SUM(INF.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
ORDER BY SUM(INF.QUANTIDADE) DESC

-- Calcule o percentual das vendas por ano:

--Calcular o total do ano:

SELECT 
YEAR(NF.DATA_VENDA) AS ANO
, SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY YEAR(NF.DATA_VENDA)

-- Para colocar os dois resultados em um resultado:

SELECT
VS.SABOR, VS.ANO, VS.VENDA_ANO, VA.VENDA_TOTAL_ANO
FROM 
(
SELECT
TP.SABOR
,YEAR(NF.DATA_VENDA) AS ANO
,SUM(INF.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
) VS
INNER JOIN
(
SELECT 
YEAR(NF.DATA_VENDA) AS ANO
, SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY YEAR(NF.DATA_VENDA)
) VA
ON VS.ANO = VA.ANO

-- Vamos ordenar pelo campo VS.VENDA_ANO

SELECT
VS.SABOR, VS.ANO, VS.VENDA_ANO, VA.VENDA_TOTAL_ANO
FROM 
(
SELECT
TP.SABOR
,YEAR(NF.DATA_VENDA) AS ANO
,SUM(INF.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
) VS
INNER JOIN
(
SELECT 
YEAR(NF.DATA_VENDA) AS ANO
, SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY YEAR(NF.DATA_VENDA)
) VA
ON VS.ANO = VA.ANO
ORDER BY VS.VENDA_ANO DESC

-- Vamos achar o percentual dos valores das vendas:

SELECT
VS.SABOR, VS.ANO, VS.VENDA_ANO, VA.VENDA_TOTAL_ANO,
(VS.VENDA_ANO / VA.VENDA_TOTAL_ANO) * 100 AS PERCENTUAL
FROM 
(
SELECT
TP.SABOR
,YEAR(NF.DATA_VENDA) AS ANO
,SUM(INF.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
) VS
INNER JOIN
(
SELECT 
YEAR(NF.DATA_VENDA) AS ANO
, SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY YEAR(NF.DATA_VENDA)
) VA
ON VS.ANO = VA.ANO
ORDER BY VS.VENDA_ANO DESC

--  Vamos converter os campos

SELECT
VS.SABOR, VS.ANO, VS.VENDA_ANO, VA.VENDA_TOTAL_ANO,
(CONVERT( FLOAT, VS.VENDA_ANO) / CONVERT( FLOAT, VA.VENDA_TOTAL_ANO)) * 100 AS PERCENTUAL
FROM 
(
SELECT
TP.SABOR
,YEAR(NF.DATA_VENDA) AS ANO
,SUM(INF.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
) VS
INNER JOIN
(
SELECT 
YEAR(NF.DATA_VENDA) AS ANO
, SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2015
GROUP BY YEAR(NF.DATA_VENDA)
) VA
ON VS.ANO = VA.ANO
ORDER BY VS.VENDA_ANO DESC

-- Para restringir a resposta para duas casas decimais

SELECT
VS.SABOR, VS.ANO, VS.VENDA_ANO,
ROUND((CONVERT( FLOAT, VS.VENDA_ANO) / CONVERT( FLOAT, VA.VENDA_TOTAL_ANO)) * 100, 2) AS PERCENTUAL
FROM 
(
SELECT
TP.SABOR
,YEAR(NF.DATA_VENDA) AS ANO
,SUM(INF.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS TP
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON TP.CODIGO_DO_PRODUTO = INF.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS NF
ON INF.NUMERO = NF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2016
GROUP BY TP.SABOR, YEAR(NF.DATA_VENDA)
) VS
INNER JOIN
(
SELECT 
YEAR(NF.DATA_VENDA) AS ANO
, SUM(INF.QUANTIDADE) AS VENDA_TOTAL_ANO
FROM NOTAS_FISCAIS NF
INNER JOIN ITENS_NOTAS_FISCAIS INF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA_VENDA) = 2016
GROUP BY YEAR(NF.DATA_VENDA)
) VA
ON VS.ANO = VA.ANO
ORDER BY VS.VENDA_ANO DESC;