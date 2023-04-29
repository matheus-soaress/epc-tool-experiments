export dir_base_perf=/PPgSI/perf-reports/
main()
{
    rm "$dir_base_perf"$1-*.csv
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
    if [ $2 = "--no-cov" ] 
    then
        get_tempo_sem_cobertura $1 $versao_inicial $versao_final
    else
        get_cobertura $1 $versao_inicial $versao_final
    fi
}
get_cobertura()
{
    for j in $(seq $2 $3);
    do
        if ( [ $1 != "Lang" ] || [ $j -ne 2 ] ) && ( [ $1 != "Cli" ] || [ $j -ne 6 ] ) && ( [ $1 != "Closure" ] || ( [ $j -ne 63 ] || [ $j -ne 93 ] ) && ( [ $1 != "Time" ] || [ $j -ne 21 ] ) )
        then 
            echo "execucao versao "$j"b;" > "$dir_base_perf"$1-jacoco-temp.csv
            echo "execucao versao "$j"b;" > "$dir_base_perf"$1-node-temp.csv
            echo "execucao versao "$j"b;" > "$dir_base_perf"$1-edge-temp.csv
            echo "execucao versao "$j"b;" > "$dir_base_perf"$1-edge-pair-temp.csv
            for i in $(seq 1 10);
            do
                /usr/bin/time -o "$dir_base_perf"$1-jacoco-temp.csv --append -f "%E;" ./get-project-version-cov.sh $1 jacoco $j
                /usr/bin/time -o "$dir_base_perf"$1-node-temp.csv --append -f "%E;" ./get-project-version-cov.sh $1 node $j
                /usr/bin/time -o "$dir_base_perf"$1-edge-temp.csv --append -f "%E;" ./get-project-version-cov.sh $1 edge $j
                /usr/bin/time -o "$dir_base_perf"$1-edge-pair-temp.csv --append -f "%E;" ./get-project-version-cov.sh $1 edge-pair $j
            done
            tr -d '\n' < "$dir_base_perf"$1-jacoco-temp.csv >> "$dir_base_perf"$1-jacoco.csv
            tr -d '\n' < "$dir_base_perf"$1-node-temp.csv >> "$dir_base_perf"$1-node.csv
            tr -d '\n' < "$dir_base_perf"$1-edge-temp.csv >> "$dir_base_perf"$1-edge.csv
            tr -d '\n' < "$dir_base_perf"$1-edge-pair-temp.csv >> "$dir_base_perf"$1-edge-pair.csv
            echo "" >> "$dir_base_perf"$1-jacoco.csv
            echo "" >> "$dir_base_perf"$1-node.csv
            echo "" >> "$dir_base_perf"$1-edge.csv
            echo "" >> "$dir_base_perf"$1-edge-pair.csv
        fi
    done
    rm "$dir_base_perf"$1-*-temp.csv
}
get_tempo_sem_cobertura()
{
    for j in $(seq $2 $3);
    do
        if ( [ $1 != "Lang" ] || [ $j -ne 2 ] ) && ( [ $1 != "Cli" ] || [ $j -ne 6 ] ) && ( [ $1 != "Closure" ] || ( [ $j -ne 63 ] || [ $j -ne 93 ] ) && ( [ $1 != "Time" ] || [ $j -ne 21 ] ) )
        then
            echo "execucao versao "$j"b;" > "$dir_base_perf"$1-original-temp.csv
            for i in $(seq 1 10);
            do
                /usr/bin/time -o "$dir_base_perf"$1-original-temp.csv --append -f "%E;" ./get-project-version-cov.sh $1 original $j
            done
            tr -d '\n' < "$dir_base_perf"$1-original-temp.csv >> "$dir_base_perf"$1-original.csv
            echo "" >> "$dir_base_perf"$1-original.csv
        fi
    done
    rm "$dir_base_perf"$1-*-temp.csv
}
main $1 $2