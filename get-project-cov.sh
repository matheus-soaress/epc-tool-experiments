main()
{
    rm /PPgSI/$1-*.txt
    case $1 in
        "chart")
            versao_inicial=1
            versao_final=26
            projeto=Chart
            dir_fonte=""
            ;;
        "csv")
            versao_inicial=1
            versao_final=16
            projeto=Csv
            dir_fonte="target"
            ;;
        "cli")
            versao_inicial=1
            versao_final=40
            projeto=Cli
            ;;
        "time")
            versao_inicial=1
            versao_final=27
            projeto=Time
            ;;
    esac
    
    get_cobertura $1 $versao_inicial $versao_final $projeto
}
get_cobertura()
{
    for j in $(seq $2 $3);
    do
        echo "\nexecucao versao "$j"b;" >> /PPgSI/$1-jacoco.txt
        echo "\nexecucao versao "$j"b;" >> /PPgSI/$1-node.txt
        echo "\nexecucao versao "$j"b;" >> /PPgSI/$1-edge.txt
        echo "\nexecucao versao "$j"b;" >> /PPgSI/$1-edge-pair.txt
        for i in $(seq 1 10);
        do
            /usr/bin/time -o /PPgSI/$1-jacoco.txt --append -f "%E;" ./get-project-version-cov.sh $4 jacoco $j
            /usr/bin/time -o /PPgSI/$1-node.txt --append -f "%E;" ./get-project-version-cov.sh $4 node $j
            /usr/bin/time -o /PPgSI/$1-edge.txt --append -f "%E;" ./get-project-version-cov.sh $4 edge $j
            /usr/bin/time -o /PPgSI/$1-edge-pair.txt --append -f "%E;" ./get-project-version-cov.sh $4 edge-pair $j
        done
    done
}
main $1