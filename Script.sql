WITH sales_data AS (
    SELECT 
        a.Name AS artist,
        g.Name AS genre,
        SUM(il.UnitPrice * il.Quantity) AS sales
    FROM 
        Artist a
    JOIN 
        Album al ON a.ArtistId = al.ArtistId
    JOIN 
        Track t ON al.AlbumId = t.AlbumId
    JOIN 
        Genre g ON t.GenreId = g.GenreId
    JOIN 
        InvoiceLine il ON t.TrackId = il.TrackId
    GROUP BY 
        a.Name, g.Name
),
total_sales AS (
    SELECT 
        genre, 
        SUM(sales) AS total_sales
    FROM 
        sales_data
    GROUP BY 
        genre
),
sales_percentage AS (
    SELECT 
        sd.artist, 
        sd.genre, 
        sd.sales, 
        ROUND((sd.sales / ts.total_sales) * 100, 1) AS sales_by_percentage_by_genre
    FROM 
        sales_data sd
    JOIN 
        total_sales ts ON sd.genre = ts.genre
)
SELECT 
    sp.artist, 
    sp.genre, 
    sp.sales, 
    sp.sales_by_percentage_by_genre,
    ROUND(SUM(sp.sales_by_percentage_by_genre) OVER (PARTITION BY sp.genre ORDER BY sp.sales_by_percentage_by_genre DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 1) AS cumulative_sum_by_genre
FROM 
    sales_percentage sp
ORDER BY 
    sp.genre ASC, sp.sales_by_percentage_by_genre DESC
LIMIT 10;
