#!/bin/bash

case $BLOCK_BUTTON in
    1) xdg-open https://www.otodom.pl/schowek/wyszukiwania/ && echo "" ;;
esac

/home/dmazuruk/tools/curlfire/curlfire -s 'https://www.otodom.pl/schowek/wyszukiwania/' > /tmp/otodom

house_count=$(grep -Pzo "<a.*/dom.*\\n*.*Pokaż\\s\\K\\d+" /tmp/otodom | tr '\0' '\n')
flat_count=$(grep -Pzo "<a.*/mieszkanie.*\\n*.*Pokaż\\s\\K\\d+" /tmp/otodom | tr '\0' '\n')
plot_count=$(grep -Pzo "<a.*/dzialka.*\\n*.*Pokaż\\s\\K\\d+" /tmp/otodom | tr '\0' '\n')
result=""

if [[ -n "$house_count" ]]; then
  result="🏠 $house_count "
fi

if [[ -n "$flat_count" ]]; then
  result="$result 🏢 $flat_count "
fi

if [[ -n "$plot_count" ]]; then
  result="$result 🏞️ $plot_count"
fi

echo "$result" | xargs

exit 0
