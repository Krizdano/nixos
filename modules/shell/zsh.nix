{ pkgs, config, ...}: 

{

 # shell(zsh)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    dotDir = ".config/zsh";
    history.path = "${config.xdg.dataHome}/zsh/zsh_history";
    autocd = true;
    shellAliases = {
      ll = "ls -l"; 
      ls = "ls --color=always";
      nt = ''pushd ~; find .nixconfig/notes -name '*.md' | fzf --preview="glow {}" | xargs vi; popd'';
      notes = ''pushd ~; find Documents/notes/vimwiki/ -name '*.md' | fzf --preview="glow {}" | xargs glow -p; popd'';
      conf =''pushd ~; find .nixconfig -name '*.nix' | fzf --preview="pistol {}" | xargs vi; popd''; # nixos configuration
            # update nixos using flakes
      update = "pushd ~/.nixconfig 
                \n nix flake update
                \n popd"; 


      gp = "cp -r ~/.nixconfig/*  ~/nixos/ 
            \n pushd ~/nixos
            \n git add * 
            \n git commit  
            \n git push 
            \n popd "; 

      # w3m with google search 
      gg = "w3m google.com";
    };

    completionInit = "autoload -Uz compinit
                      zstyle ':completion:*' menu select
                      zmodload zsh/complist
                      compinit
                      ";


                     # envExtra = 

    defaultKeymap = "viins";
    initExtra = 
    ''eval "$(starship init zsh)"  
      export KEYTIMEOUT=1
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

