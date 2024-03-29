export dir_base=/PPgSI
export dir_jacoco=$dir_base/jacoco/org.jacoco.cli/target/org.jacoco.cli-0.8.8-nodeps.jar
export dir_jacoco_agent=$dir_base/jacoco/org.jacoco.agent.rt/target/org.jacoco.agent.rt-0.8.8-all.jar
export dir_destino_jacoco=$dir_base/out-jacoco
export dir_xml_jacoco=$dir_base"/reports/"$1"-"$3"b-jacoco.xml"
export dir_epc_tool=$dir_base/edge-pair-cov-tool/ba-cf-cli/target/ba-cf-cli-0.0.1-all.jar
export dir_destino_epc_tool=$dir_base/out-epc-tool
export dir_xml_epc_tool=$dir_base"/reports/"$1"-"$3"b"
export classes_teste="$(defects4j export -p tests.all -w $dir_base"/projects/"$1"/"$3"b" | tr '\n' ' ')"
export classpath="$(defects4j export -p cp.test -w $dir_base"/projects/"$1"/"$3"b")"
export dir_fonte=$dir_base"/projects/"$1"/"$3"b/"
export dir_fonte_src="$(defects4j export -p dir.bin.classes -w $dir_base"/projects/"$1"/"$3"b")"
export dir_fonte_test="$(defects4j export -p dir.bin.tests -w $dir_base"/projects/"$1"/"$3"b")"
export dir_fonte_classpath="\/PPgSI\/projects\/"$1"\/"$3"b\/"
main() 
{
    echo $1"-"$3"b"
    classe_junit="org.junit.runner.JUnitCore"
    case $classpath in
        *"junit-3"*)
            classe_junit="junit.textui.TestRunner"
            ;;
        *"junit-4"*)
            classe_junit="org.junit.runner.JUnitCore"
            ;;
    esac
    if [ $1 = "Csv" ]; then
        classe_junit="org.junit.runner.JUnitCore junit.textui.TestRunner"
    fi
    if [ $1 = "Compress" ]; then
        find $dir_fonte""$dir_fonte_test -maxdepth 1 ! -regex '^$dir_fonte""$dir_fonte_test"/org"' -delete
    fi
    case $2 in
        "jacoco")
            get_cobertura_jacoco $dir_fonte_classpath $classe_junit $4 $1 $3
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
        "original")
            get_tempo_original $dir_fonte_classpath $classe_junit
            ;;
    esac
}
get_cobertura_jacoco() 
{
    rm ./jacoco.exec
    rm -r $dir_destino_jacoco/*
    java -jar $dir_jacoco instrument $dir_fonte"$dir_fonte_src" --dest $dir_destino_jacoco"/"$dir_fonte_src
    java -jar $dir_jacoco instrument $dir_fonte"$dir_fonte_test" --dest $dir_destino_jacoco"/"$dir_fonte_test
    dir_destino_jacoco_cp_src="/PPgSI/out-jacoco/"$dir_fonte_src
    dir_destino_jacoco_cp_test="/PPgSI/out-jacoco/"$dir_fonte_test
    dir_src_original=$1""$dir_fonte_src
    dir_test_original=$1""$dir_fonte_test
    classpath_jacoco=$(echo $classpath | sed "s,$dir_src_original,$dir_destino_jacoco_cp_src,g")
    classpath_jacoco=$(echo $classpath_jacoco | sed "s,$dir_test_original,$dir_destino_jacoco_cp_test,g")
    java -cp "$dir_jacoco_agent:$classpath_jacoco" $2 $classes_teste
    if [ $3 = "cp" ]; then
        echo $4"-"$5"b:"$classpath_jacoco >> /PPgSI/classpaths.txt
    fi
    java -jar $dir_jacoco report ./jacoco.exec --classfiles $dir_fonte"$dir_fonte_src" --classfiles $dir_fonte"$dir_fonte_test" --xml $dir_xml_jacoco
    rm ./jacoco.exec
}
get_cobertura_nos()
{
    rm ./coverage.ser
    rm -r $dir_destino_epc_tool/*
    java -jar $dir_epc_tool instrument -src $dir_fonte"$dir_fonte_src" -dest $dir_destino_epc_tool"/"$dir_fonte_src
    java -jar $dir_epc_tool instrument -src $dir_fonte"$dir_fonte_test" -dest $dir_destino_epc_tool"/"$dir_fonte_test
    dir_destino_epc_tool_cp_src="/PPgSI/out-epc-tool/"$dir_fonte_src
    dir_destino_epc_tool_cp_test="/PPgSI/out-epc-tool/"$dir_fonte_test
    dir_src_original=$1""$dir_fonte_src
    dir_test_original=$1""$dir_fonte_test
    classpath_epc_tool=$(echo $classpath | sed "s,$dir_src_original,$dir_destino_epc_tool_cp_src,g")
    classpath_epc_tool=$(echo $classpath_epc_tool | sed "s,$dir_test_original,$dir_destino_epc_tool_cp_test,g")
    java -cp "$dir_epc_tool:$classpath_epc_tool" $2 $classes_teste
    java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-node.xml
    rm ./coverage.ser
}
get_cobertura_arestas()
{
    rm ./coverage.ser
    rm -r $dir_destino_epc_tool/*
    java -jar $dir_epc_tool instrument -src $dir_fonte"$dir_fonte_src" -dest $dir_destino_epc_tool"/"$dir_fonte_src -edges
    java -jar $dir_epc_tool instrument -src $dir_fonte"$dir_fonte_test" -dest $dir_destino_epc_tool"/"$dir_fonte_test -edges
    dir_destino_epc_tool_cp_src="/PPgSI/out-epc-tool/"$dir_fonte_src
    dir_destino_epc_tool_cp_test="/PPgSI/out-epc-tool/"$dir_fonte_test
    dir_src_original=$1""$dir_fonte_src
    dir_test_original=$1""$dir_fonte_test
    classpath_epc_tool=$(echo $classpath | sed "s,$dir_src_original,$dir_destino_epc_tool_cp_src,g")
    classpath_epc_tool=$(echo $classpath_epc_tool | sed "s,$dir_test_original,$dir_destino_epc_tool_cp_test,g")
    java -cp "$dir_epc_tool:$classpath_epc_tool" $2 $classes_teste
    java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-edge.xml -edges
    rm ./coverage.ser
}
get_cobertura_pares_arestas()
{
    rm ./coverage.ser
    rm -r $dir_destino_epc_tool/*
    java -jar $dir_epc_tool instrument -src $dir_fonte"$dir_fonte_src" -dest $dir_destino_epc_tool"/"$dir_fonte_src -edge-pairs
    java -jar $dir_epc_tool instrument -src $dir_fonte"$dir_fonte_test" -dest $dir_destino_epc_tool"/"$dir_fonte_test -edge-pairs
    dir_destino_epc_tool_cp_src="/PPgSI/out-epc-tool/"$dir_fonte_src
    dir_destino_epc_tool_cp_test="/PPgSI/out-epc-tool/"$dir_fonte_test
    dir_src_original=$1""$dir_fonte_src
    dir_test_original=$1""$dir_fonte_test
    classpath_epc_tool=$(echo $classpath | sed "s,$dir_src_original,$dir_destino_epc_tool_cp_src,g")
    classpath_epc_tool=$(echo $classpath_epc_tool | sed "s,$dir_test_original,$dir_destino_epc_tool_cp_test,g")
    java -cp "$dir_epc_tool:$classpath_epc_tool" $2 $classes_teste
    java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-edge-pair.xml -edge-pairs
    rm ./coverage.ser
}
get_tempo_original()
{
    java -cp "$classpath" $2 $classes_teste
}
# $1 = Programa/Projeto
# $2 = Ferramenta de cobertura
# $3 = Versão do programa
# $4 = Exporta classpath ou não ("cp" para sim)
main $1 $2 $3 $4