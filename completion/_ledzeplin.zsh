#compdef ledzeplin

_ledzeplin() {
    local curcontext="$curcontext" state line
    typeset -A opt_args

    _arguments \
        '1: :->command'\
        '*:: :->subcmd'

    case $state in
    (command)
        local -a commands
        commands=(
            account:'Manage Zeplin account'
            login:'Login to Zeplin'
            logout:'Logout from Zeplin'
            switch:'Switch login using different Zeplin account'
            help:'Show help'
        )
        _describe -t all_commands "all commands" commands
        ;;
    (subcmd)
        case ${line[1]} in
            (login|switch)
                local -a accounts
                accounts=()
                if [[ -f "$HOME/.config/ledzeplin" ]]; then
                    accounts=( "${(@f)$(< $HOME/.config/ledzeplin)}" )
                fi
                compadd -a accounts
            ;;
        esac
    esac

    return 1
}