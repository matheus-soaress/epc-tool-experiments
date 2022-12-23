main()
{
    case $1 in 
        "Csv")
            testa_csv
            ;;
    esac
}
testa_csv() 
{
    for i in $(seq 0 10);
    do
        time -o /PPgSI/chart-jacoco.txt --append -f "%E;" ./get-cov-csv.sh jacoco 
        time -o /PPgSI/chart-node.txt --append -f "%E;" ./get-cov-csv.sh node
        time -o /PPgSI/chart-edge.txt --append -f "%E;" ./get-cov-csv.sh edge
        time -o /PPgSI/chart-edge-pair.txt --append -f "%E;" ./get-cov-csv.sh edge-pair
    done
}
main