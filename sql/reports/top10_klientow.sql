-- Raport: Top 10 klientów
-- Cel biznesowy: Wskazanie największych klientów
-- Wykorzystanie modelu: Fakt + dim_klient

SELECT k.imie, k.nazwisko, SUM(f.wartosc) AS laczna_wartosc
FROM fakt_zamowienie f
JOIN dim_klient k ON f.klient_id = k.klient_id
GROUP BY k.imie, k.nazwisko
ORDER BY laczna_wartosc DESC
LIMIT 10;