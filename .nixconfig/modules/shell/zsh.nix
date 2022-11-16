{ pkgs, ...}: 

{

 # shell(zsh)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    autocd = true;
    completionInit = "autoload -Uz compinit
                      zstyle ':completion:*' menu select
                      zmodload zsh/complist
                      compinit
                      ";



    #defaultKeymap = "viins";
    initExtra = 
    ''eval "$(starship init zsh)"  
      setopt extendedglob nomatch notify
      unsetopt BEEP
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history

      function zle-keymap-select {
       if [[ ''${KEYMAP} == vicmd ]] ||
          [[ $1 = 'block' ]]; then 
        echo -ne '\e[1 q'
       elif [[ ''${KEYMAP} == main ]] ||
            [[ ''${KEYMAP} == viins ]] ||
            [[ ''${KEYMAP} == ' ' ]] ||
            [[ $1 = 'beam' ]]; then 
          echo -ne '\e[5 q'
         fi
       }
      zle -N zle-keymap-select
      zle-line-init() {
        zle -K viins
        echo -ne "\e[5q"
      }
      zle -N zle-line-init
      echo -ne '\e[5 q'
      preexec() { echo -ne '\e[5 q' ;}
      ''; 

      
                  
  };

}

