# Análise de vendas de música com SQL
Este repositório contém um script SQL para analisar as vendas de música por artista e gênero.                                                                                                                                                                                    
 O script foi criado como parte de um desafio para demonstrar o uso avançado de SQL e boas práticas de programação.
## Proposta do desafio 
O objetivo é criar uma consulta SQL que permita replicar os resultados de uma tabela específica. 

Imagem da tabela original:
<img src="/upload.photos/tabela.original.png">

A tabela contém uma análise das vendas de música, mostrando o total de vendas (faturamento), a porcentagem de vendas por gênero e a soma acumulada da porcentagem de vendas por gênero para cada artista. 

A consulta deve retornar os dez primeiros resultados, ordenados por gênero em ordem ascendente e por porcentagem de vendas em ordem descendente.
## Solução proposta
O script SQL neste repositório é dividido em quatro partes:
- **sales_data:** Reúne os dados de vendas por artista e gênero. Ela junta várias tabelas para calcular o total de vendas para cada combinação de artista e gênero.
- **total_sales:** Calcula o total de vendas para cada gênero.
- **sales_percentage:** Calcula a porcentagem de vendas para cada combinação de artista e gênero.
- **Consulta principal:** Seleciona os dados finais a serem retornados. Ela calcula a soma acumulada da porcentagem de vendas por gênero e ordena os resultados.
## Resultado
Imagem da tabela: 


<img src="/upload.photos/tabela.replica.png">
