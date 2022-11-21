#bin/env sh
#
printf "\nchoose what to edit \n"
printf "\n laptop \n vm \n zsh \n main \n sway \n kitty \n\n flakes \n all \n\n :"
read input 

case $input in 
 zsh|z)

  vi ~/.nixconfig/modules/shell/zsh.nix
  ;;

 main|m)

   vi ~/.nixconfig/hosts/configuration.nix
   ;;

 laptop|l)

   vi ~/.nixconfig/hosts/laptop/default.nix
   ;;

 vm|v)

    vi ~/.nixconfig/hosts/vm/default.nix
    ;;

 sway|s)
      
    vi ~/.nixconfig/modules/WindowManagers/sway.nix
    ;;

 kitty|k)
      
    vi ~/.nixconfig/modules/programs/kitty.nix
    ;;

 programs|p)
      
    vi ~/.nixconfig/modules/programs
    ;;

esac

if [ $input == flakes ]||
     [ $input == f ]||
     [ $input == 2 ];
then
printf "\n which file do you need to edit \n"
printf "\n main \n host \n :"
read flakeinput

case $flakeinput in
  main|m)
	  
   vi ~/.nixconfig/flake.nix
   ;;

   host|h)
    vi ~/.nixconfig/hosts/default.nix
    ;;

esac

elif [ $input == all ] ||
     [ $input == a ] ||
     [ $input == 3 ];
then 
  vi ~/.nixconfig

else 
 printf "i don't know what youre talking about"

fi
