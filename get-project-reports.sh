export dir_base_perf=/PPgSI/perf-reports/
main()
{
    rm "$dir_base_perf"$1-*.txt
    case $1 in
        "Chart")
            versao_inicial=1
            versao_final=26
            dir_fonte=""
            ;;
        "Cli")
            versao_inicial=1
            versao_final=40
            dir_fonte="target"
            ;;
        "Closure")
            versao_inicial=1
            versao_final=176
            dir_fonte="build"
            ;;
        "Codec")
            versao_inicial=1
            versao_final=18
            dir_fonte="target"
            ;;
        "Collections")
            versao_inicial=25
            versao_final=28
            dir_fonte="target"
            ;;
        "Compress")
            versao_inicial=1
            versao_final=47
            dir_fonte="target"
            ;;
        "Csv")
            versao_inicial=1
            versao_final=16
            dir_fonte="target"
            ;;
        "Gson")
            versao_inicial=1
            versao_final=18
            dir_fonte="target"
            ;;
        "JacksonCore")
            versao_inicial=1
            versao_final=26
            dir_fonte="target"
            ;;
        "JacksonDatabind")
            versao_inicial=1
            versao_final=112
            dir_fonte="target"
            ;;
        "JacksonXml")
            versao_inicial=1
            versao_final=6
            dir_fonte="target"
            ;;
        "Jsoup")
            versao_inicial=1
            versao_final=93
            dir_fonte="target"
            ;;
        "JxPath")
            versao_inicial=1
            versao_final=22
            dir_fonte="target"
            ;;
        "Lang")
            versao_inicial=1
            versao_final=65
            dir_fonte="target"
            ;;
        "Math")
            versao_inicial=1
            versao_final=106
            dir_fonte="target"
            ;;
        "Mockito")
            versao_inicial=1
            versao_final=38
            dir_fonte="build"
            ;;
        "Time")
            versao_inicial=1
            versao_final=27
            dir_fonte="target"
            ;;
    esac
    
    get_cobertura $1 $versao_inicial $versao_final $2
}
get_cobertura()
{
    for j in $(seq $2 $3);
    do
        if ( [ $1 != "Lang" ] || [ $j -ne 2 ] ) && ( [ $1 != "Cli" ] || [ $j -ne 6 ] ) && ( [ $1 != "Closure" ] || ( [ $j -ne 63 ] || [ $j -ne 93 ] ) && ( [ $1 != "Time" ] || [ $j -ne 21 ] ) )
        then
            ./get-project-version-cov.sh $1 jacoco $j $4
            ./get-project-version-cov.sh $1 node $j $4
            ./get-project-version-cov.sh $1 edge $j $4
            ./get-project-version-cov.sh $1 edge-pair $j $4
        fi
    done
}
# $1 = Projeto/Programa
# $2 = Exporta classpath ou não ("cp" para sim)
main $1 $2