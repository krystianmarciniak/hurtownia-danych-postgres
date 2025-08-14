\copy public.dim_kategoria 
FROM 'C:/Users/kryst/Documents/hurtownia-danych-postgres/seeds/dim_kategoria.csv' 
CSV HEADER;

\copy public.dim_produkt 
FROM 'C:/Users/kryst/Documents/hurtownia-danych-postgres/seeds/dim_produkt.csv' 
CSV HEADER;

\copy public.dim_klient 
FROM 'C:/Users/kryst/Documents/hurtownia-danych-postgres/seeds/dim_klient.csv' 
CSV HEADER;

\copy public.dim_czas 
FROM 'C:/Users/kryst/Documents/hurtownia-danych-postgres/seeds/dim_czas.csv' 
CSV HEADER;

\copy public.fakt_zamowienie 
FROM 'C:/Users/kryst/Documents/hurtownia-danych-postgres/seeds/fakt_zamowienie.csv' 
CSV HEADER;