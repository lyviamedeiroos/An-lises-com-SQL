-- A consulta começa com uma tabela temporária chamada 'sales_data'
-- que calcula o total de vendas para cada combinação de artista e gênero.
WITH sales_data AS (
    SELECT 
        a.Name AS artist,  -- Nome do artista
        g.Name AS genre,  -- Gênero da música
        SUM(il.UnitPrice * il.Quantity) AS sales  -- Total de vendas
    FROM 
        Artist a  -- Tabela de artistas
    JOIN 
        Album al ON a.ArtistId = al.ArtistId  -- Join com a tabela de álbuns
    JOIN 
        Track t ON al.AlbumId = t.AlbumId  -- Join com a tabela de faixas
    JOIN 
        Genre g ON t.GenreId = g.GenreId  -- Join com a tabela de gêneros
    JOIN 
        InvoiceLine il ON t.TrackId = il.TrackId  -- Join com a tabela de linhas de fatura
    GROUP BY 
        a.Name, g.Name  -- Agrupa por artista e gênero
),
-- A próxima tabela temporária 'total_sales' calcula o total de vendas para cada gênero.
total_sales AS (
    SELECT 
        genre,  -- Gênero da música
        SUM(sales) AS total_sales  -- Total de vendas
    FROM 
        sales_data  -- Usa os dados da tabela 'sales_data'
    GROUP BY 
        genre  -- Agrupa por gênero
),
-- A tabela 'sales_percentage' calcula a porcentagem de vendas para cada combinação de artista e gênero.
sales_percentage AS (
    SELECT 
        sd.artist,  -- Nome do artista
        sd.genre,  -- Gênero da música
        sd.sales,  -- Total de vendas
        ROUND((sd.sales / ts.total_sales) * 100, 1) AS sales_by_percentage_by_genre  -- Porcentagem de vendas por gênero
    FROM 
        sales_data sd  -- Usa os dados da tabela 'sales_data'
    JOIN 
        total_sales ts ON sd.genre = ts.genre  -- Junta com a tabela 'total_sales'
)
-- A consulta principal seleciona os dados finais a serem retornados.
SELECT 
    sp.artist,  -- Nome do artista
    sp.genre,  -- Gênero da música
    sp.sales,  -- Total de vendas
    sp.sales_by_percentage_by_genre,  -- Porcentagem de vendas por gênero
    ROUND(SUM(sp.sales_by_percentage_by_genre) OVER (PARTITION BY sp.genre ORDER BY sp.sales_by_percentage_by_genre DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 1) AS cumulative_sum_by_genre  -- Soma acumulada da porcentagem de vendas por gênero
FROM 
    sales_percentage sp  -- Usa os dados da tabela 'sales_percentage'
ORDER BY 
    sp.genre ASC, sp.sales_by_percentage_by_genre DESC  -- Ordena por gênero em ordem ascendente e porcentagem de vendas em ordem descendente
LIMIT 10;  -- Limita os resultados às dez primeiras linhas
