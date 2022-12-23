main()
{
    rm /PPgSI/$1-*.txt
    for i in $(seq 0 10);
    do
        /usr/bin/time -o /PPgSI/$1-jacoco.txt --append -f "%E;" ./get-cov-$1.sh jacoco 
        /usr/bin/time -o /PPgSI/$1-node.txt --append -f "%E;" ./get-cov-$1.sh node
        /usr/bin/time -o /PPgSI/$1-edge.txt --append -f "%E;" ./get-cov-$1.sh edge
        /usr/bin/time -o /PPgSI/$1-edge-pair.txt --append -f "%E;" ./get-cov-$1.sh edge-pair
    done
}
main $1