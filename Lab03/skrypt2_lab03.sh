#!/bin/bash -eu


# Z pliku yolo.csv wypisz wszystkich, których id jest liczbą nieparzystą. 
# Wyniki zapisz na standardowe wyjście błędów. 
echo "Z pliku yolo.csv wypisz wszystkich, których id jest liczbą nieparzystą."
cat ./samples/yolo.csv | grep -E "^[0-9]?[0-9]?[0-9]?[1,3,5,7,9]," 1>&2
 
# Z pliku yolo.csv wypisz każdego, kto jest wart dokładnie $2.99 lub $5.99 lub $9.99. 
# Nie wazne czy milionów, czy miliardów (tylko nazwisko i wartość). Wyniki zapisz na standardowe wyjście błędów 
echo "Z pliku yolo.csv wypisz każdego, kto jest wart dokładnie \$2.99 lub \$5.99 lub \$9.99."
cat ./samples/yolo.csv | cut -d',' -f3,7 | grep "\$[259]\.99[B|M]" 1>&2

# Z pliku yolo.csv wypisz każdy numer IP, który w pierwszym i drugim oktecie ma po jednej cyfrze. 
# Wyniki zapisz na standardowe wyjście błędów
echo "Z pliku yolo.csv wypisz każdy numer IP, który w pierwszym i drugim oktecie ma po jednej cyfrze."
cat ./samples/yolo.csv | cut -d',' -f6 | grep -E "^[0-9]\.[0-9]\." 1>&2