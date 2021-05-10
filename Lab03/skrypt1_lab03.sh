#!/bin/bash -eu


# Znajdź w pliku access_log zapytania, które mają frazę "denied" w linku
echo "Znajdź w pliku access_log zapytania, które mają frazę denied w linku"
cat ./samples/access_log | grep "\/denied"

# Znajdź w pliku access_log zapytania typu POST
echo -e "\nZnajdź w pliku access_log zapytania typu POST"
cat ./samples/access_log | cut -d' ' -f1,2,6,7 | grep "\"POST"

# Znajdź w pliku access_log zapytania wysłane z IP: 64.242.88.10
echo -e "\nZnajdź w pliku access_log zapytania wysłane z IP: 64.242.88.10"
cat ./samples/access_log | cut -d' ' -f1,2,6,7 | grep "^64\.242\.88\.10 "

# Znajdź w pliku access_log wszystkie zapytania NIEWYSŁANE z adresu IP tylko z FQDN
echo -e "\nZnajdź w pliku access_log wszystkie zapytania NIEWYSŁANE z adresu IP tylko z FQDN"
cat ./samples/access_log | cut -d' ' -f1,2,6,7 | grep -E "^[a-z]"

# Znajdź w pliku access_log unikalne zapytania typu DELETE
echo -e "\nZnajdź w pliku access_log unikalne zapytania typu DELETE"
cat ./samples/access_log | cut -d' ' -f1,2,6,7 | grep "\"DELETE" | sort -u

# Znajdź unikalnych 10 adresów IP w access_log
echo -e "\nZnajdź unikalnych 10 adresów IP w access_log"
cat ./samples/access_log | cut -d' ' -f1 | grep -E "^([0-9][0-9])" | sort -u | sed 10q