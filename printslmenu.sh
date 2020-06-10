export nnn=$(ls -t Pak* | slmenu)
cmd=$(awk -v nnn="$nnn" '/\$nnn/ {sub("\\$nnn",nnn);} {print NR". " $0;} ' /home/wim/printtools/printcmds.txt | slmenu -m 1 -l 10"$@") 
selection=${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.selection
#cat $selection
exec $cmd  
#echo $cmd
