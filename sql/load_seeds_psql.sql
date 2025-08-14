\copy public.dim_kategoria (nazwa_kategorii) FROM 'C:/Users/kryst/Documents/hurtownia-danych-postgres/seeds/dim_kategoria.csv' CSV HEADER;
\copy public.dim_produkt (nazwa, parametr, cena_brutto, id_kategoria) FROM 'C:/Users/kryst/Documents/hurtownia-danych-postgres/seeds/dim_produkt.csv' CSV HEADER;
\copy public.dim_klient (imie, nazwisko, miasto, ulica, email) FROM 'C:/Users/kryst/Documents/hurtownia-danych-postgres/seeds/dim_klient.csv' CSV HEADER;
\copy public.dim_czas (data, rok, miesiac, dzien, dzien_tygodnia) FROM 'C:/Users/kryst/Documents/hurtownia-danych-postgres/seeds/dim_czas.csv' CSV HEADER;
\copy public.fakt_zamowienie (klient_id, produkt_id, czas_id, ilosc, wartosc, status) FROM 'C:/Users/kryst/Documents/hurtownia-danych-postgres/seeds/fakt_zamowienie.csv' CSV HEADER;
