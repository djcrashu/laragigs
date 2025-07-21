### **Krok 1: Git clone **

```
git clone https://github.com/djcrashu/laragigs
cd laragigs
```


### **Krok 5: Budowa i uruchomienie kontenerów**

Ta komenda zbuduje obraz i uruchomi wszystkie trzy kontenery w tle.

**Generated bash**

```
docker-compose up -d --build
```

Use code [**with caution**](https://support.google.com/legal/answer/13505487).Bash

Po tym kroku Twój lokalny katalog laragigs jest zamontowany w kontenerze, ale uprawnienia do zapisu są jeszcze niepoprawne.

### **Krok 6: Finalizacja instalacji (Poprawiona kolejność)**

Poniższe kroki należy wykonać w tej konkretnej kolejności.

1. **Napraw uprawnienia do plików (NAJPIERW!).** To kluczowy krok, który pozwala Laravelowi zapisywać pliki logów i cache. Musi być wykonany jako pierwszy.

   **Generated bash**

   ```
   docker-compose exec app chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
   ```

   Use code [**with caution**](https://support.google.com/legal/answer/13505487).Bash
2. **Zainstaluj lub zaktualizuj zależności PHP.** Ta komenda pobierze wszystkie biblioteki potrzebne do działania projektu i zapisze je w nowo utworzonym katalogu vendor.

   **Generated bash**

   ```
   docker-compose exec app composer install
   ```

   Use code [**with caution**](https://support.google.com/legal/answer/13505487).Bash

   *Jeśli napotkasz błędy z kompatybilnością PHP, użyj zamiast tego composer update.*
3. **Wygeneruj klucz aplikacji.** Jest on niezbędny do bezpiecznego działania aplikacji.

   **Generated bash**

   ```
   docker-compose exec app php artisan key:generate
   ```

   Use code [**with caution**](https://support.google.com/legal/answer/13505487).Bash
4. **Uruchom migracje bazy danych.** Ta komenda stworzy wszystkie potrzebne tabele w bazie danych.

   **Generated bash**

   ```
   docker-compose exec app php artisan migrate
   ```

   Use code [**with caution**](https://support.google.com/legal/answer/13505487).Bash
5. **(Opcjonalnie) Wypełnij bazę danych danymi testowymi.**

   **Generated bash**

   ```
   docker-compose exec app php artisan db:seed
   ```

   Use code [**with caution**](https://support.google.com/legal/answer/13505487).Bash

### **Gotowe!**
