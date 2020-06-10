#!/bin/bash 
SimplePrint(){
	echo "Print"
	lp -d BROLPD -o fit-to-page -o Media=A4 -o BRMonoColor=Mono -o BRResolution=PlainFast -o BRBiDIR=OFF $1
}
MaxEtiket(){
	fontsize=16
	echo $fontsize
	pages=$(cat /tmp/o.txt |  iconv -futf-8 -tlatin1 | enscript --margins=:4:: -MAdress -o"/tmp/v.ps" -B -r -fHelvetica@$fontsize 2>&1 | awk '{print $2}' | grep -o '[0-9]*') 
	echo "pages:-"$pages"-"
	while [ $pages -gt 1 ]
	do
	fontsize=$(($fontsize - 1))
	echo "fontsize:"$fontsize
	pages=$(cat /tmp/o.txt  | iconv -futf-8 -tlatin1 | enscript --margins=:4:: -MAdress -o"/tmp/v.ps" -B -r -fHelvetica@$fontsize 2>&1 | awk '{print $2}' | grep -o '[0-9]*') 
	done
}

zathura $1 &
zathura_PID=$!
sleep 1.5
echo focusstack+ >> /tmp/dwm.fifo
while true; do
    read -p "1. Dymobol\\n2. Simple Print\\n3. Exit? 4. Skip [1]234 :" yn
    yn=${yn:-1} 
    case $yn in
        [1]* )  SimplePrint $1; kill $zathura_PID; break;;
        [2]* )  SimplePrint $1; kill $zathura_PID; exit;;
        [3]* )  kill $zathura_PID; exit;;
        [4]* )  kill $zathura_PID; break;;
        * ) echo "Choose 1234";;
    esac
done

gs -sDEVICE=txtwrite -o /tmp/o.gs $1
head -n5 /tmp/o.gs  | awk -F " {3,}" ' {if (toupper($2)!="BELGIË"){print toupper($2) }}' | awk '/BELGI/ {if (NR==4 || NR==5){next}} /./ {print}' | iconv -futf-8 -tlatin1 > /tmp/o.txt 
MaxEtiket
zathura /tmp/v.ps &
zathura_PID=$!
sleep 1.5
echo focusstack+ >> /tmp/dwm.fifo
while true; do
    read -p "1. Print Etiket+Bat Etiket\\n2.  Print Etiket\\n3.  Edit Etiket\\n4. Exit? [1]234 :" yn
    yn=${yn:-1} 
    case $yn in
        [1]* )  lp -d DYMO /tmp/v.ps;kill $zathura_PID; lp -d DYMO /home/wim/printtools/batlandsticker.pdf;break;;
        [2]* )  lp -d DYMO /tmp/v.ps;kill $zathura_PID; break;;
        [3]* )  vim /tmp/o.txt; MaxEtiket;lp -d DYMO /tmp/v.ps; kill $zathura_PID; break;;
        [4]* )  kill $zathura_PID; exit;;
        * ) echo "Choose 123";;
    esac
done
