# Hurtownia danych – PostgreSQL + Pentaho

Projekt implementuje hurtownię danych w architekturze **Star Schema** zasilaną procesem **ETL** w Pentaho Data Integration (Spoon) oraz zawiera zestaw raportów SQL w PostgreSQL.

---

## 1️ Opis projektu

Celem projektu jest stworzenie hurtowni danych na podstawie plików CSV, obejmującej:
- **Modelowanie schematu gwiazdy** (tabela faktów + tabele wymiarów)
- **Proces ETL** w Pentaho
- **Ładowanie danych do PostgreSQL**
- **Raporty analityczne SQL**

---

## 2️ Struktura repozytorium

├── docs/
│ └── screenshots/ # Zrzuty ekranu z działania projektu
├── etl/ # Pliki ETL Pentaho (.ktr, .kjb)
├── schema/ # Skrypty DDL do tworzenia tabel
├── seeds/ # Pliki CSV z danymi źródłowymi
├── sql/
│ ├── reports/ # Zapytania SQL raportów
│ ├── hurtownia.sql # Pełny schemat bazy
│ ├── load_seeds.sql # Skrypty ładowania danych
└── README.md # Dokumentacja projektu


---

## 3️ Model danych

Schemat hurtowni składa się z:

- **dim_klient** – dane klientów
- **dim_produkt** – dane produktów
- **dim_kategoria** – kategorie produktów
- **dim_czas** – wymiar czasu
- **fakt_zamowienie** – tabela faktów z zamówieniami

![Model ETL](Load_Job.png)

---

## 4️ Proces ETL (Pentaho)

- Każda tabela wymiarów i faktów ładowana jest z pliku CSV przy użyciu transformacji **.ktr**
- Główny job (`load_hd_job.kjb`) uruchamia transformacje w odpowiedniej kolejności:
  1. dim_czas
  2. dim_kategoria
  3. dim_produkt
  4. dim_klient
  5. fakt_zamowienie

![Transformacje](Transformacje%201.png)

---

## 5️ Raporty SQL

### 5.1 Przychód miesięczny
Analiza sumarycznej wartości zamówień zrealizowanych w danym roku i miesiącu.

Plik: [`sql/reports/przychod_miesieczny.sql`](sql/reports/przychod_miesieczny.sql)  
![Przychód miesięczny](przychod_miesieczny.png)

---

### 5.2 Sprzedaż wg kategorii
Ranking kategorii produktów według łącznego przychodu.

Plik: [`sql/reports/sprzedaz_wg_kategorii.sql`](sql/reports/sprzedaz_wg_kategorii.sql)  
![Analiza dochodowości](Analiza_dochodowosci.png)

---

### 5.3 Top 10 klientów
Lista dziesięciu klientów o najwyższej łącznej wartości zamówień.

Plik: [`sql/reports/top10_klientow.sql`](sql/reports/top10_klientow.sql)  
![Top 10 klientów](Top_10_klientow.png)

---

## 6️ Wymagania

- **PostgreSQL** ≥ 14
- **Pentaho Data Integration (Spoon)** ≥ 9.0
- Dane źródłowe w formacie CSV
- Kodowanie UTF-8

---

## 7️ Instrukcja uruchomienia

1. Utwórz pustą bazę:
   ```sql
   CREATE DATABASE hurtownia
       WITH OWNER = postgres
       ENCODING = 'UTF8'
       LC_COLLATE = 'pl_PL'
       LC_CTYPE = 'pl_PL'
       TEMPLATE template0;

Załaduj schemat:

psql -U postgres -d hurtownia -f schema/hurtownia.sql


Uruchom job load_hd_job.kjb w Pentaho, aby załadować dane z CSV.

Wykonaj zapytania z folderu sql/reports/, aby wygenerować raporty.

8️ Autor

Krystian Marciniak

9️ Źródła i dokumentacja

Pełna dokumentacja znajduje się w pliku:
Dokumentacja Hurtownia danych.pdf