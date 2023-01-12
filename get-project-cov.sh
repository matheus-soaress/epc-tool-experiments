export dir_base_perf=/PPgSI/perf-reports/
main()
{
    rm "$dir_base_perf"$1-*.txt
    case $1 in
        "chart")
            versao_inicial=1
            versao_final=26
            projeto=Chart
            dir_fonte=""
            ;;
        "cli")
            versao_inicial=1
            versao_final=40
            projeto=Cli
            dir_fonte="target"
            ;;
        "closure")
            projeto="Closure"
            versao_inicial=1
            versao_final=176
            dir_fonte="build"
            ;;
        "codec")
            projeto="Codec"
            versao_inicial=1
            versao_final=18
            dir_fonte="target"
            ;;
        "collections")
            projeto="Collections"
            versao_inicial=25
            versao_final=28
            dir_fonte="target"
            ;;
        "compress")
            projeto="Compress"
            versao_inicial=1
            versao_final=47
            dir_fonte="target"
            ;;
        "csv")
            projeto="Csv"
            versao_inicial=1
            versao_final=16
            dir_fonte="target"
            ;;
        "gson")
            projeto="Gson"
            versao_inicial=1
            versao_final=18
            dir_fonte="target"
            ;;
        "jackson-core")
            projeto="JacksonCore"
            versao_inicial=1
            versao_final=26
            dir_fonte="target"
            ;;
        "jackson-databind")
            projeto="JacksonDatabind"
            versao_inicial=1
            versao_final=112
            dir_fonte="target"
            ;;
        "jackson-xml")
            projeto="JacksonXml"
            versao_inicial=1
            versao_final=6
            dir_fonte="target"
            ;;
        "jsoup")
            projeto="Jsoup"
            versao_inicial=1
            versao_final=93
            dir_fonte="target"
            ;;
        "jxPath")
            projeto="JxPath"
            versao_inicial=1
            versao_final=22
            dir_fonte="target"
            ;;
        "lang")
            projeto="Lang"
            versao_inicial=1
            versao_final=65
            dir_fonte="target"
            ;;
        "math")
            projeto="Math"
            versao_inicial=1
            versao_final=106
            dir_fonte="target"
            ;;
        "mockito")
            projeto="Mockito"
            versao_inicial=1
            versao_final=38
            dir_fonte="build"
            ;;
        "time")
            versao_inicial=1
            versao_final=27
            projeto=Time
            dir_fonte="target"
            ;;
    esac
    
    get_cobertura $1 $versao_inicial $versao_final $projeto
}
get_cobertura()
{
    for j in $(seq $2 $3);
    do
        if ( [ $1 != "lang" ] || [ $j -ne 2 ] ) && ( [ $1 != "cli" ] || [ $j -ne 6 ] ) && ( [ $1 != "closure" ] || ( [ $j -ne 63 ] || [ $j -ne 93 ] ) && ( [ $1 != "time" ] || [ $j -ne 21 ] ) )
        then 
            echo "\nexecucao versao "$j"b;" > "$dir_base_perf"$1-jacoco-temp.txt
            echo "\nexecucao versao "$j"b;" > "$dir_base_perf"$1-node-temp.txt
            echo "\nexecucao versao "$j"b;" > "$dir_base_perf"$1-edge-temp.txt
            echo "\nexecucao versao "$j"b;" > "$dir_base_perf"$1-edge-pair-temp.txt
            for i in $(seq 1 10);
            do
                /usr/bin/time -o "$dir_base_perf"$1-jacoco-temp.txt --append -f "%E;" ./get-project-version-cov.sh $4 jacoco $j
                /usr/bin/time -o "$dir_base_perf"$1-node-temp.txt --append -f "%E;" ./get-project-version-cov.sh $4 node $j
                /usr/bin/time -o "$dir_base_perf"$1-edge-temp.txt --append -f "%E;" ./get-project-version-cov.sh $4 edge $j
                /usr/bin/time -o "$dir_base_perf"$1-edge-pair-temp.txt --append -f "%E;" ./get-project-version-cov.sh $4 edge-pair $j
            done
            tr -d '\n' < "$dir_base_perf"$1-jacoco-temp.txt >> "$dir_base_perf"$1-jacoco.txt
            tr -d '\n' < "$dir_base_perf"$1-node-temp.txt >> "$dir_base_perf"$1-node.txt
            tr -d '\n' < "$dir_base_perf"$1-edge-temp.txt >> "$dir_base_perf"$1-edge.txt
            tr -d '\n' < "$dir_base_perf"$1-edge-pair-temp.txt >> "$dir_base_perf"$1-edge-pair.txt
            echo "" >> "$dir_base_perf"$1-jacoco.txt
            echo "" >> "$dir_base_perf"$1-node.txt
            echo "" >> "$dir_base_perf"$1-edge.txt
            echo "" >> "$dir_base_perf"$1-edge-pair.txt
        fi
    done
    rm "$dir_base_perf"$1-*-temp.txt
}
main $1