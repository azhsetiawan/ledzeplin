_ledzeplin() {
    arr=()
    if [ -e "$HOME/.config/ledzeplin" ]; then
        while IFS= read -r line; do
            arr+=("$line")
        done <"$HOME/.config/ledzeplin"
    fi

    local acco="${arr[@]}"
    local commands="account help login logout switch"
    local cur prev

    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    case ${COMP_CWORD} in
        1)
            COMPREPLY=($(compgen -W "$commands" -- "${cur}"))
            ;;
        2)
            case ${prev} in
                login)
                    COMPREPLY=($(compgen -W "$acco" -- "${cur}"))
                    ;;
                switch)
                    COMPREPLY=($(compgen -W "$acco" -- "${cur}"))
                    ;;
            esac
            ;;
        *)
            COMPREPLY=()
            ;;
    esac
}

complete -F _ledzeplin ledzeplin