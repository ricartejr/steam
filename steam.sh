#!/usr/bin/env bash
# Nome: Ricarte Jr

# Download (top 125 descontos) steam busca por relevancia.
# As 5 primeiras paginas de promocao da steamem uma lista como links.txt
# http://store.steampowered.com/search/?sort_by=&sort_order=0&specials=1&page=1
# http://store.steampowered.com/search/?sort_by=&sort_order=0&specials=1&page=2
# http://store.steampowered.com/search/?sort_by=&sort_order=0&specials=1&page=3
# http://store.steampowered.com/search/?sort_by=&sort_order=0&specials=1&page=4
# http://store.steampowered.com/search/?sort_by=&sort_order=0&specials=1&page=5


# grep -Eo "\-(.|..|...)%" steam

### CORES ###
today=`date +%d-%m-%Y-%H-%M-%S`
BREDTEXTWHITE="\e[41;37;01m"
BREDTEXTWHITEP="\e[41;37;05m"
FIMCOR="\e[m"

clear
echo "+-----------------------------------------------+"
echo -e "\t $BREDTEXTWHITE Aguarde fazendo download... $FIMCOR"
sleep 1 ; wget -q -i links.txt -O steam && echo -e "\t Download finalizado com sucesso"
echo "+-----------------------------------------------+"
echo -e "\t $BREDTEXTWHITE Verificando descontos $FIMCOR"
# sleep 1 ; grep -Eo "\-..\%" steam 2>&1 | sed 's/-..%/[ & ]/g' > descontos.txt && echo -e "\t Descontos encontrados ($BREDTEXTWHITEP`cat descontos.txt | wc -l`$FIMCOR)"
# sleep 1 ; grep -Eo "\-.*\%" steam 2>&1 | grep -v "\-tooltip" | sed 's/-.*%/[ & ]/g' | sed 's/-.%/& /g' > descontos.txt && echo -e "\t Descontos encontrados ($BREDTEXTWHITEP`cat descontos.txt | wc -l`$FIMCOR)"
sleep 1 ; grep -Eo "\-(.|..|...)%" steam | sed 's/-.*%/[ & ]/g ; s/-.%/& /g' > descontos.txt && echo -e "\t Descontos encontrados ($BREDTEXTWHITEP`cat descontos.txt | wc -l`$FIMCOR)"
sleep 1 ; grep "<span class=\"title\">" steam 2>&1 | sed 's/^.*<span class=\"title\">/[ /g ; s/<\/span*./ ]/g' | sed 's/[®,–,]/ /g' > nomes.txt && echo -e "\t Atualizados ($BREDTEXTWHITE`cat nomes.txt | wc -l`$FIMCOR) nomes"
sleep 1 ; grep "strike" steam 2>&1 | cut -d">" -f3,6 | sed 's/^/[ &/g ; s/<\/strike>/	= /g ; s/	*<\/div$/	]/g' | expand -t 10 > valor.txt && echo -e "\t Valores atualizados ($BREDTEXTWHITE`cat valor.txt | wc -l`$FIMCOR)"
sleep 1 ; paste -d "+" descontos.txt valor.txt nomes.txt 2>&1 > tabeladepreco.txt && echo -e "\t Tabela de descontos criada ($BREDTEXTWHITE`cat tabeladepreco.txt | wc -l`$FIMCOR)"
sleep 1 ; `sort -nr -t\- -k2 tabeladepreco.txt > ${today}-tabeladeprecofinal.txt`
sleep 1 ; rm descontos.txt valor.txt nomes.txt tabeladepreco.txt steam && echo -e "\n\t $BREDTEXTWHITEP Arquivos desnecessários apagado com sucesso. $FIMCOR\n"
exit