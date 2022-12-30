main() {
    case $1 in
        "chart")
            projeto="Chart"
            versao_inicial=1
            versao_final=26
            ;;
        "csv")
            projeto="Csv"
            versao_inicial=1
            versao_final=16
            ;;
        "cli")
            projeto="Cli"
            versao_inicial=1
            versao_final=40
            ;;
        "time")
            projeto="Time"
            versao_inicial=1
            versao_final=27
            ;;
    esac
    checkout_projeto $projeto $versao_inicial $versao_final
}
checkout_projeto()
{
    for i in $(seq $2 $3);
    do
        defects4j checkout -p $1 -v $i"b" -w /PPgSI/projects/$1/$i"b"
        defects4j compile -w /PPgSI/projects/$1/$i"b"
        defects4j test -w /PPgSI/projects/$1/$i"b"
    done
}
main $1