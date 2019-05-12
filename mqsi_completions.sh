#/usr/bin/env bash
_mqsilist_completions_running_eg()
{
    local prev="${COMP_WORDS[COMP_CWORD -1]}"
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local IFS=$'\n'
    COMPREPLY=()
    if [[ "${#COMP_WORDS[@]}" = "2" ]]; then
        COMPREPLY=($(compgen -W "$(ls -1 $MQSI_WORKPATH/components)" -- "${COMP_WORDS[1]}"))
        return
    elif [[ "$prev" = '-e'  ]]; then
        local broker="${COMP_WORDS[1]}"
        egs=$(ps -ef | grep DataFlowEngin | grep ${broker} | grep -v grep | grep -o '[^ ]*$')
        COMPREPLY=($(compgen -W "$egs" -- "$cur"))
        return
    else
        _filedir;
        return;
    fi
}

_mqsilist_completions()
{
    local prev="${COMP_WORDS[COMP_CWORD -1]}"
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local IFS=$'\n'
    COMPREPLY=()
    if [[ "${#COMP_WORDS[@]}" = "2" ]]; then
        COMPREPLY=($(compgen -W "$(ls -1 $MQSI_WORKPATH/components)" -- "${COMP_WORDS[1]}"))
        return
    elif [[ "$prev" = '-e'  ]]; then
        local broker="${COMP_WORDS[1]}"
        egs=""
        for l in $(echo 'cat /table/row/@ExecGroupLabel' | xmllint --shell $MQSI_WORKPATH/components/${broker}/repository/brokeraaeg.dat | awk -F\" 'NR % 2 == 0 { print $2; }' ) ; do
            egs=$(echo $l | base64 -d)$'\n'${egs};
        done
        COMPREPLY=($(compgen -W "$egs" -- "$cur"))
        return
    else
        _filedir;
        return;
    fi
}


complete -o nospace -F _mqsilist_completions_running_eg mqsilist
complete -o nospace -F _mqsilist_completions_running_eg mqsistop
complete -o nospace -F _mqsilist_completions mqsistart
complete -o nospace -F _mqsilist_completions_running_eg mqsireload
complete -o nospace -F _mqsilist_completions_running_eg mqsistopmsgflow
complete -o nospace -F _mqsilist_completions mqsistartmsgflow
complete -o default -o nospace -F _mqsilist_completions_running_eg mqsireportproperties
complete -o nospace -F _mqsilist_completions mqsicreateexecutiongroup
complete -o nospace -F _mqsilist_completions mqsideleteexecutiongroup

