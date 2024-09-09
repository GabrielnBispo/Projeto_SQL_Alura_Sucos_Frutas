-- Verifique se houve a carga correta das tabelas. Usando os comandos:

/*
Tabela de Clientes: 16 itens
Tabela de Produtos: 31 itens
Tabela de Vendedores: 4 itens
Tabela de Notas Fiscais: 87960 itens
Tabela de Itens Notas Fiscais: 213364 itens*/

SELECT COUNT(*) FROM TABELA_DE_CLIENTES;
SELECT COUNT(*) FROM TABELA_DE_PRODUTOS;
SELECT COUNT(*) FROM TABELA_DE_VENDEDORES;
SELECT COUNT(*) FROM NOTAS_FISCAIS;
SELECT COUNT(*) FROM ITENS_NOTAS_FISCAIS;
