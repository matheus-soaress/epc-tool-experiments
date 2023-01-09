export dir_base=/PPgSI
export dir_jacoco=$dir_base/jacoco/org.jacoco.cli/target/org.jacoco.cli-0.8.8-nodeps.jar
export dir_jacoco_agent=$dir_base/jacoco/org.jacoco.agent.rt/target/org.jacoco.agent.rt-0.8.8-all.jar
export dir_destino_jacoco=$dir_base/out-jacoco
export dir_xml_jacoco=$dir_base"/reports/"$1"-jacoco.xml"
export dir_epc_tool=$dir_base/edge-pair-cov-tool/epc-tool-cli/target/epc-tool-cli-0.0.1-SNAPSHOT-all.jar
export dir_destino_epc_tool=$dir_base/out-epc-tool
export dir_xml_epc_tool=$dir_base"/reports/"$1
export classes_teste="$(defects4j export -p tests.all -w $dir_base"/projects/"$1"/"$3"b" | tr '\n' ' ')"
export classpath=$(defects4j export -p cp.test -w $dir_base"/projects/"$1"/"$3"b")
export dir_fonte=$dir_base"/projects/"$1"/"$3"b/"$4
export dir_fonte_classpath="\/PPgSI\/projects\/"$1"\/"$3"b\/"$4
main() 
{
    echo $1"-"$3"b"
    if [[ "$classpath" == *"junit-3"* ]];
        then
            classe_junit="junit.textui.TestRunner"
        else
            classe_junit="org.junit.runner.JUnitCore"
    fi
    case $2 in
        "jacoco")
            get_cobertura_jacoco $dir_fonte_classpath $classe_junit
            ;;
        "node")
            get_cobertura_nos $dir_fonte_classpath $classe_junit
            ;;
        "edge")
            get_cobertura_arestas $dir_fonte_classpath $classe_junit
            ;;
        "edge-pair")
            get_cobertura_pares_arestas $dir_fonte_classpath $classe_junit
            ;;
    esac
}
get_cobertura_jacoco() 
{
    rm ./jacoco.exec
    rm -r $dir_destino_jacoco/*
    java -jar $dir_jacoco instrument $dir_fonte --dest $dir_destino_jacoco
    dir_destino_jacoco_cp="\/PPgSI\/out-jacoco\/"
    classpath_jacoco=$(echo $classpath | sed "s,$1,$dir_destino_jacoco_cp,g")
    java -cp "$dir_jacoco_agent:$classpath_jacoco" $2 $classes_teste
    java -jar $dir_jacoco report ./jacoco.exec --classfiles $dir_fonte --xml $dir_xml_jacoco
    rm ./jacoco.exec
}
get_cobertura_nos()
{
    rm ./coverage.ser
    rm -r $dir_destino_epc_tool/*
    java -jar $dir_epc_tool instrument -src $dir_fonte -dest $dir_destino_epc_tool
    dir_destino_epc_tool_cp="\/PPgSI\/out-epc-tool\/"
    classpath_epc_tool=$(echo $classpath | sed "s,$1,$dir_destino_epc_tool_cp,g")
    java -cp "$dir_epc_tool:$classpath_epc_tool" $2 $classes_teste
    java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-node.xml
    rm ./coverage.ser
}
get_cobertura_arestas()
{
    rm ./coverage.ser
    rm -r $dir_destino_epc_tool/*
    java -jar $dir_epc_tool instrument -src $dir_fonte -dest $dir_destino_epc_tool -edges
    dir_destino_epc_tool_cp="\/PPgSI\/out-epc-tool\/"
    classpath_epc_tool=$(echo $classpath | sed "s,$1,$dir_destino_epc_tool_cp,g")
    java -cp "$dir_epc_tool:$classpath_epc_tool" $2 $classes_teste
    java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-edge.xml -edges
    rm ./coverage.ser
}
get_cobertura_pares_arestas()
{
    rm ./coverage.ser
    rm -r $dir_destino_epc_tool/*
    java -jar $dir_epc_tool instrument -src $dir_fonte -dest $dir_destino_epc_tool -edge-pairs
    dir_destino_epc_tool_cp="\/PPgSI\/out-epc-tool\/"
    classpath_epc_tool=$(echo $classpath | sed "s,$1,$dir_destino_epc_tool_cp,g")
    java -cp "$dir_epc_tool:$classpath_epc_tool" $2 $classes_teste
    java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-edge-pair.xml -edge-pairs
    rm ./coverage.ser
}
main $1 $2 $3