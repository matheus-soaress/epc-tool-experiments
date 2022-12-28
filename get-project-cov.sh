main()
{
    rm /PPgSI/$1-*.txt
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
    get_cobertura $1 $versao_inicial $versao_final
}
checkout_projeto()
{
    for i in $(seq $2 $3);
    do
        defects4j checkout -p $1 -v $i"b" -w /PPgSI/projects/$1/$i"b"
        defects4j compile -w /PPgSI/projects/$1/$i"b"
    done
}
get_cobertura()
{
    for j in $(seq $2 $3);
    do
        for i in $(seq 1 10);
        do
            echo "\nexecucao $i - versao $j b" >> /PPgSI/$1-jacoco.txt
            /usr/bin/time -o /PPgSI/$1-jacoco.txt --append -f "%E;" ./get-cov-$1.sh jacoco $j
            echo "\nexecucao $i - versao $j b" >> /PPgSI/$1-node.txt
            /usr/bin/time -o /PPgSI/$1-node.txt --append -f "%E;" ./get-cov-$1.sh node $j
            echo "\nexecucao $i - versao $j b" >> /PPgSI/$1-edge.txt
            /usr/bin/time -o /PPgSI/$1-edge.txt --append -f "%E;" ./get-cov-$1.sh edge $j
            echo "\nexecucao $i - versao $j b" >> /PPgSI/$1-edge-pair.txt
            /usr/bin/time -o /PPgSI/$1-edge-pair.txt --append -f "%E;" ./get-cov-$1.sh edge-pair $j
        done
    done
}
main $1