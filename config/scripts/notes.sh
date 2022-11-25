notes=$( find Documents/notes/ -name '*.md' | fzf -e )

[ -z "$notes" ] && exit 0

 glow -p $notes 

