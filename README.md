# Hurtownia danych (PostgreSQL) — ETL + Power BI

Repozytorium zawiera:
- `schema/000_init.sql` — struktura bazy (tabele dim/fact, klucze).
- `seeds/` — anonimowe próbki danych CSV.
- `sql/` — przykładowe raporty SQL.
- `etl/` — eksporty z Apache NiFi / Pentaho (opcjonalnie).
- `docs/` — dokumentacja, diagramy, screeny.

## Szybki start

1. Utwórz bazę danych `hurtownia`.
2. Wgraj schemat:
   ```bash
   psql -h localhost -U postgres -d hurtownia -f schema/000_init.sql
