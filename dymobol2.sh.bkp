fontsize=16
echo $fontsize
lp -d BROLPD -o BRMonoColor=Mono -o BRResolution=PlainFast $1
gs -sDEVICE=txtwrite -o /tmp/o.gs $1
pages=$(head -n5 /tmp/o.gs  | awk -F " {3,}" ' {if (toupper($2)!="BELGIË"){print toupper($2) }}' | awk '/BELGI/ {if (NR==4 || NR==5){next}} /./ {print}' | iconv -futf-8 -tlatin1 | enscript -MAdress -o"/tmp/v.ps" -B -r -fHelvetica@$fontsize 2>&1 | awk '{print $2}' | grep -o '[0-9]*') 
echo "pages:-"$pages"-"
while [ $pages -gt 1 ]
do
fontsize=$(($fontsize - 1))
echo "fontsize:"$fontsize
pages=$(head -n5 /tmp/o.gs  | awk -F " {3,}" ' {if (toupper($2)!="BELGIË"){print toupper($2) }}' | awk '/BELGI/ {if (NR==4 || NR==5){next}} /./ {print}' | iconv -futf-8 -tlatin1 | enscript -MAdress -o"/tmp/v.ps" -B -r -fHelvetica@$fontsize 2>&1 | awk '{print $2}' | grep -o '[0-9]*') 
done
lp -d DYMO /tmp/v.ps
