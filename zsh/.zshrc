### ZSH SOURCE FILES ###
export ZDOTDIR=~/.zsh

for file in $ZDOTDIR/zsh_*; do
  source $file
##echo "$(basename $file | sed 's/^zsh_//g') loaded"
done

setopt always_to_end          # move the cursor to the end of the word
setopt append_history         # this is default, but set for share_history
setopt auto_list              # automatically list choices on ambiguous completion
setopt auto_menu              # automatically use menu completion
setopt auto_pushd             # Make cd push each old directory onto the stack
#setopt completeinword         # If unset, the cursor is set to the end of the word
setopt extended_glob          # treat #, ~, and ^ as part of patterns for filename
#setopt extended_history       # save command's beginning timestamp and duration 
setopt glob_dots              # dot files included in regular globs
setopt hist_expire_dups_first # delete duplicates firstin history 
setopt hist_find_no_dups      # don't show results already cycled through twice
setopt hist_ignore_dups       # Do not write duplicates
setopt hist_reduce_blanks     # remove superfluous blanks
setopt hist_verify            # show command with history expansion
setopt histignorespace        # remove commands when the first character is a space
setopt interactivecomments    # allow use of comments in interactive code
setopt longlistjobs           # display PID when suspending processes as well
setopt no_beep                # silence all bells and beeps
setopt nonomatch              ## try to avoid the 'zsh: no matches found...'
setopt noshwordsplit          # use zsh style word splitting
setopt notify                 # report the status of backgrounds jobs immediately
setopt numeric_glob_sort      # globs sorted numerically
setopt pushd_ignore_dups      # Don't push duplicates onto the stack
setopt share_history          # share history between instances of the shell

