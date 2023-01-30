main() {
    case $1 in
        "chart")
            projeto="Chart"
            versao_inicial=1
            versao_final=26
            ;;
        "cli")
            projeto="Cli"
            versao_inicial=1
            versao_final=40
            ;;
        "closure")
            projeto="Closure"
            versao_inicial=1
            versao_final=176
            ;;
        "codec")
            projeto="Codec"
            versao_inicial=1
            versao_final=18
            ;;
        "collections")
            projeto="Collections"
            versao_inicial=25
            versao_final=28
            ;;
        "compress")
            projeto="Compress"
            versao_inicial=1
            versao_final=47
            ;;
        "csv")
            projeto="Csv"
            versao_inicial=1
            versao_final=16
            ;;
        "gson")
            projeto="Gson"
            versao_inicial=1
            versao_final=18
            ;;
        "jackson-core")
            projeto="JacksonCore"
            versao_inicial=1
            versao_final=26
            ;;
        "jackson-databind")
            projeto="JacksonDatabind"
            versao_inicial=1
            versao_final=112
            ;;
        "jackson-xml")
            projeto="JacksonXml"
            versao_inicial=1
            versao_final=6
            ;;
        "jsoup")
            projeto="Jsoup"
            versao_inicial=1
            versao_final=93
            ;;
        "jxPath")
            projeto="JxPath"
            versao_inicial=1
            versao_final=22
            ;;
        "lang")
            projeto="Lang"
            versao_inicial=1
            versao_final=65
            ;;
        "math")
            projeto="Math"
            versao_inicial=1
            versao_final=106
            ;;
        "mockito")
            projeto="Mockito"
            versao_inicial=1
            versao_final=38
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
        if ( [ $1 != "Lang" ] || [ $i -ne 2 ] ) && ( [ $1 != "Cli" ] || [ $i -ne 6 ] ) && ( [ $1 != "Closure" ] || ( [ $i -ne 63 ] || [ $i -ne 93 ] ) && ( [ $1 != "Time" ] || [ $i -ne 21 ] ) )
        then 
            defects4j checkout -p $1 -v $i"b" -w /PPgSI/projects/$1/$i"b"
            defects4j compile -w /PPgSI/projects/$1/$i"b"
            if ( [ $1 != Compress ] )
            then
                defects4j test -w /PPgSI/projects/$1/$i"b"
            fi
        fi
    done
}
main $1