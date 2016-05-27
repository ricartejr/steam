#!/usr/bin/env bash
# Nome: Ricarte Jr

# Download (top 125 descontos) steam busca por relevancia.
# As 5 primeiras paginas de promocao da steamem uma lista como links.txt
# http://store.steampowered.com/search/?sort_by=&sort_order=0&specials=1&page=1
# http://store.steampowered.com/search/?sort_by=&sort_order=0&specials=1&page=2
# http://store.steampowered.com/search/?sort_by=&sort_order=0&specials=1&page=3
# http://store.steampowered.com/search/?sort_by=&sort_order=0&specials=1&page=4
# http://store.steampowered.com/search/?sort_by=&sort_order=0&specials=1&page=5

# LINK COTACAO DO DOLAR ATUALIZADO
# https://es.finance.yahoo.com/q?s=USDBRL=X

clear
echo "Aguarde fazendo download...#"
sleep 1 ; wget -qi links.txt -O steam && echo "# '----[ Download (100 %) ]"
echo "Atualizando cotacao"
sleep 1 ; grep -Eo "yfs_l10_usdbrl\=x.{8}</span>" steam 2>&1 | cut -d\> -f2 | sed 's/<\/span$//g ; s/^.*/[ Dolar = & ]/g' > cambio.txt && echo " '---- `cat cambio.txt`"
echo "Verificando descontos"
sleep 1 ; grep -Eo "\-..\%" steam 2>&1 | sed 's/-..%/[ & ]/g' > descontos.txt && echo " '---- [ Descontos atualizados (`cat descontos.txt | wc -l`) ]"
echo "Organizando nomes"
sleep 1 ; grep "<span class=\"title\">" steam 2>&1 | sed 's/^.*<span class=\"title\">/[ /g ; s/<\/span*./ ]/g' | sed 's/[®,–,]/ /g' > nomes.txt && echo " '---- [ Nomes atualizados (`cat nomes.txt | wc -l`) ]"
echo "Verificando valores"
sleep 1 ; grep "strike" steam 2>&1 | cut -d">" -f3,6 | sed 's/^/[ &/g ; s/<\/strike>/	= /g ; s/	*<\/div$/	]/g' | expand -t 10 > valor.txt && echo " '---- [ Valores atualizados (`cat valor.txt | wc -l`) ]"
echo "Criando tabela com descontos, valor e nome"
sleep 1 ; paste -d"+" descontos.txt valor.txt nomes.txt 2>&1 > tabeladepreco.txt && echo "  '---- [ Tabela criada (`cat tabeladepreco.txt | wc -l`) ]"
echo "Adicionando a cotacao do dolar no final da tabela"
sleep 1 ; cat cambio.txt 2>&1 >> tabeladepreco.txt && echo "  '---- [ Cotacao (OK) ]"
echo "Apagando arquivos desnecessários"
sleep 1 ; rm descontos.txt valor.txt nomes.txt cambio.txt steam && echo "  '---- [ Arquivos removidos (5) ]"
exit