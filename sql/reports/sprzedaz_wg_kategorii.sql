-- Raport: Sprzedaż wg kategorii
-- Cel biznesowy: Analiza dochodowości kategorii
-- Wykorzystanie modelu: Fakt + dim_produkt + dim_kategoria

SELECT kat.nazwa_kategorii, SUM(f.wartosc) AS przychod
FROM fakt_zamowienie f
JOIN dim_produkt   p   ON f.produkt_id   = p.produkt_id
JOIN dim_kategoria kat ON p.id_kategoria = kat.kategoria_id
GROUP BY kat.nazwa_kategorii
ORDER BY przychod DESC;