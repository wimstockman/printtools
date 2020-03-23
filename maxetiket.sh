fontsize=16
echo $fontsize
pages=$(cat $1  |  iconv -futf-8 -tlatin1 | enscript -MAdress -o"/tmp/v.ps" -B -r -fHelvetica@$fontsize 2>&1 | awk '{print $2}' | grep -o '[0-9]*') 
echo "pages:-"$pages"-"
while [ $pages -gt 1 ]
do
fontsize=$(($fontsize - 1))
echo "fontsize:"$fontsize
pages=$(cat $1  | iconv -futf-8 -tlatin1 | enscript -MAdress -o"/tmp/v.ps" -B -r -fHelvetica@$fontsize 2>&1 | awk '{print $2}' | grep -o '[0-9]*') 
done
lp -d DYMO /tmp/v.ps
