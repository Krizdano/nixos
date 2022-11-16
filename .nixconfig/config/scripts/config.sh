#bin/env sh
#
printf "\nchoose what to edit \n"
printf " flakes \n configs \n:"

read choice

if [ $choice == configs ]||
   [ $choice == c ]||
   [ $choice == 2 ];
then 
printf "\n which file do you need to edit \n"
printf "\n laptop \n vm \n zsh \n main \n\n :"
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

 sway|v)
      
    vi ~/.nixconfig/modules/WindowManagers/sway.nix
    ;;
 *)

  echo "sorry wrong input"
  ;;

esac

elif [ $choice == flakes ]||
     [ $choice == f ]||
     [ $choice == 2 ];
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

else 
 printf "i don't know what youre talking about"

fi
