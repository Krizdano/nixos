#bin/env sh
#
printf "\nchoose what to edit \n"
printf " flakes \n configs \n:"

read choice

if [ $choice == configs ];
then 
printf "\n which file do you need to edit \n"
printf "\n laptop \n vm \n zsh \n main \n\n :"
read input 

case $input in 
 zsh)

  vi ~/.nixconfig/modules/shell/zsh.nix
  ;;

 main)

   vi ~/.nixconfig/hosts/configuration.nix
   ;;

 laptop)

   vi ~/.nixconfig/hosts/laptop/default.nix
   ;;

 vm)

    vi ~/.nixconfig/hosts/vm/default.nix
    ;;

 *)

  echo "sorry wrong input"
  ;;

esac

elif [ $choice == flakes ];
then
printf "\n which file do you need to edit \n"
printf "\n main \n host \n :"
read flakeinput

case $flakeinput in
  main)
	  
   vi ~/.nixconfig/flake.nix
   ;;

   host)
    vi ~/.nixconfig/hosts/default.nix
    ;;

esac

else 
 printf "i don't know what youre talking about"

fi
