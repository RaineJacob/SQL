This is a analysis of Chinook music Store data. This database has 11 tables.


# Countries with the most invoices
SELECT billing_country, COUNT(*) AS number_of_invoices FROM invoice
GROUP BY billing_country
ORDER BY number_of_invoices DESC


# Top five cities for Invoice 
SELECT billing_city, sum(total) AS invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC
LIMIT 5


# Top 5 customers with their spendings
SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spending
FROM customer c 
JOIN invoice i 
ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total_spending DESC
LIMIT 5


# All classical music listeners details
SELECT DISTINCT email AS EmailId, first_name AS FirstName, last_name AS LastName, g.name AS genre
FROM customer c
JOIN invoice i ON i.customer_id = c.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name LIKE "Classical"
ORDER BY email;


# Sales for each country with respect to genre
SELECT COUNT(*) AS Sales_per_Genre, g.name, g.genre_id, c.country
FROM customer c
JOIN invoice i ON i.customer_id = c.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN genre g ON g.genre_id = t.genre_id
GROUP BY g.name, g.genre_id, c.country
ORDER By g.name DESC


# Track lenths with more then Avg track length and a minute column
SELECT name, milliseconds, (milliseconds / 1000) / 60 AS Minutes
FROm track
WHERE milliseconds >(
  SELECT AVG(milliseconds) AS Avg_track_length
  FROM track)
ORDER BY milliseconds DESC


# Countries with most Rock tracks purchased 
SELECT i.billing_country, COUNT(*) Rock_tracks_purchased
FROM invoice i 
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON t.track_id = il.track_id
    join genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Rock'
GROUP BY billing_country
ORDER BY Rock_tracks_purchased DESC
LIMIT 10


# Most albums by a composer
SELECT composer, Count(album_id) AS number_of_album
FROM track
GROUP BY composer
ORDER BY number_of_album desc


# Most albums by an artist
SELECT COUNT(album_id) AS total_album, at.name
FROM album a 
	JOIN artist at ON a.artist_id = at.artist_id
GROUP BY at.name
ORDER BY total_album DESC
