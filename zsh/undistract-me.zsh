# commands to ignore
cmdignore=(htop tmux top vim git less bat)

# end and compare timer, notify-send if needed
function notifyosd-precmd() {
	retval=$?
    if [[ ${cmdignore[(r)$cmd_basename]} == $cmd_basename ]]; then
        return
    else
        if [ ! -z "$cmd" ]; then
            cmd_end=`date +%s`
            ((cmd_time=$cmd_end - $cmd_start))
        fi
        if [ $retval -gt 0 ]; then
            icon="cross-mark"
        else
            icon="check-mark"
        fi
        if [ ! -z "$cmd" -a $cmd_time -gt 3 ]; then
            timeout="$(((cmd_time / 3) * 1000))"
            if [ ! -z $SSH_TTY ] ; then
                notify-send -t $timeout -i $icon "\"$cmd\" took $cmd_time seconds"
            else
                notify-send -t $timeout -i $icon "\"$cmd\" ${cmd_time}s"
            fi
        fi
        unset cmd
    fi
}

# make sure this plays nicely with any existing precmd
precmd_functions+=( notifyosd-precmd )

# get command name and start the timer
function notifyosd-preexec() {
    cmd=$1
    cmd_basename=${${cmd:s/sudo //}[(ws: :)1]}
    cmd_start=`date +%s`
}

# make sure this plays nicely with any existing preexec
preexec_functions+=( notifyosd-preexec )
