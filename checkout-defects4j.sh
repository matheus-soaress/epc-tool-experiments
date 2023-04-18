main() {
    case $1 in
        "Chart")
            versao_inicial=1
            versao_final=26
            ;;
        "Cli")
            versao_inicial=1
            versao_final=40
            ;;
        "Closure")
            versao_inicial=1
            versao_final=176
            ;;
        "Codec")
            versao_inicial=1
            versao_final=18
            ;;
        "Collections")
            versao_inicial=25
            versao_final=28
            ;;
        "Compress")
            versao_inicial=1
            versao_final=47
            ;;
        "Csv")
            versao_inicial=1
            versao_final=16
            ;;
        "Gson")
            versao_inicial=1
            versao_final=18
            ;;
        "JacksonCore")
            versao_inicial=1
            versao_final=26
            ;;
        "JacksonDatabind")
            versao_inicial=1
            versao_final=112
            ;;
        "JacksonXml")
            versao_inicial=1
            versao_final=6
            ;;
        "Jsoup")
            versao_inicial=1
            versao_final=93
            ;;
        "JxPath")
            versao_inicial=1
            versao_final=22
            ;;
        "Lang")
            versao_inicial=1
            versao_final=65
            ;;
        "Math")
            versao_inicial=1
            versao_final=106
            ;;
        "Mockito")
            versao_inicial=1
            versao_final=38
            ;;
        "Time")
            versao_inicial=1
            versao_final=27
            ;;
    esac
    checkout_projeto $1 $versao_inicial $versao_final
}
checkout_projeto()
{
    for i in $(seq $2 $3);
    do
        if ( [ $1 != "Lang" ] || [ $i -ne 2 ] ) && ( [ $1 != "Cli" ] || [ $i -ne 6 ] ) && ( [ $1 != "Closure" ] || ( [ $i -ne 63 ] || [ $i -ne 93 ] ) && ( [ $1 != "Time" ] || [ $i -ne 21 ] ) )
        then 
            defects4j checkout -p $1 -v $i"b" -w /PPgSI/projects/$1/$i"b"
            defects4j compile -w /PPgSI/projects/$1/$i"b"
            defects4j test -w /PPgSI/projects/$1/$i"b"
        fi
    done
}
main $1