-- Raport: Przychód miesięczny
-- Cel biznesowy: Analiza sprzedaży w czasie (trend miesięczny)
-- Wykorzystanie modelu: Łączy tabelę faktów z wymiarem czasu (dim_czas), filtruje status 'zrealizowane'

SELECT c.rok, c.miesiac, SUM(f.wartosc) AS przychod
FROM fakt_zamowienie f
JOIN dim_czas c ON f.czas_id = c.czas_id
WHERE f.status = 'zrealizowane'
GROUP BY c.rok, c.miesiac
ORDER BY c.rok, c.miesiac;
