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
    
    get_cobertura $1 $versao_inicial $versao_final 
}
get_cobertura()
{
    for j in $(seq $2 $3);
    do
        if ( [ $1 != "Lang" ] || [ $j -ne 2 ] ) && ( [ $1 != "Cli" ] || [ $j -ne 6 ] ) && ( [ $1 != "Closure" ] || ( [ $j -ne 63 ] || [ $j -ne 93 ] ) && ( [ $1 != "Time" ] || [ $j -ne 21 ] ) )
        then 
            echo "execucao versao "$j"b;" > "$dir_base_perf"$1-jacoco-temp.txt
            echo "execucao versao "$j"b;" > "$dir_base_perf"$1-node-temp.txt
            echo "execucao versao "$j"b;" > "$dir_base_perf"$1-edge-temp.txt
            echo "execucao versao "$j"b;" > "$dir_base_perf"$1-edge-pair-temp.txt
            for i in $(seq 1 10);
            do
                /usr/bin/time -o "$dir_base_perf"$1-jacoco-temp.txt --append -f "%E;" ./get-project-version-cov.sh $1 jacoco $j
                /usr/bin/time -o "$dir_base_perf"$1-node-temp.txt --append -f "%E;" ./get-project-version-cov.sh $1 node $j
                /usr/bin/time -o "$dir_base_perf"$1-edge-temp.txt --append -f "%E;" ./get-project-version-cov.sh $1 edge $j
                /usr/bin/time -o "$dir_base_perf"$1-edge-pair-temp.txt --append -f "%E;" ./get-project-version-cov.sh $1 edge-pair $j
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