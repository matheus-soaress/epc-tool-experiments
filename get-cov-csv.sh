export dir_base=/PPgSI
export dir_fonte=$dir_base"/projects/Csv/"$2"b/target"
export dir_jacoco=$dir_base/jacoco/org.jacoco.cli/target/org.jacoco.cli-0.8.9-SNAPSHOT-nodeps.jar
export dir_jacoco_agent=$dir_base/jacoco/org.jacoco.agent.rt/target/org.jacoco.agent.rt-0.8.9-SNAPSHOT-all.jar
export dir_destino_jacoco=$dir_base/out-jacoco
export dir_xml_jacoco=$dir_base/reports/report-csv-jacoco.xml
export dir_lib_csv=$dir_base/defects4j/framework/projects/Csv/lib
export dir_epc_tool=$dir_base/edge-pair-cov-tool/epc-tool-cli/target/epc-tool-cli-0.0.1-SNAPSHOT-all.jar
export dir_destino_epc_tool=$dir_base/out-epc-tool
export dir_xml_epc_tool=$dir_base/reports/report-csv
# export classes_teste="org.junit.runner.JUnitCore org.apache.commons.csv.CSVFormatTest org.apache.commons.csv.CSVLexerTest org.apache.commons.csv.CSVParserTest org.apache.commons.csv.CSVPrinterTest org.apache.commons.csv.ExtendedBufferedReaderTest"
export classes_teste=$(defects4j export -p tests.all -w $dir_base"/projects/Csv/"$2"b")
export classpath=$(defects4j export -p cp.test -w $dir_base"/projects/Csv/"$2"b")
main() 
{
    echo "Csv-"$2"b"
    case $1 in
        "jacoco")
            get_cobertura_jacoco
            ;;
        "node")
            get_cobertura_nos
            ;;
        "edge")
            get_cobertura_arestas
            ;;
        "edge-pair")
            get_cobertura_pares_arestas
            ;;
    esac
}
get_cobertura_jacoco() 
{
    rm ./jacoco.exec
    rm -r $dir_destino_jacoco/*
    java -jar $dir_jacoco instrument $dir_fonte --dest $dir_destino_jacoco
    java -cp "$dir_jacoco_agent:$dir_destino_jacoco/classes:$dir_destino_jacoco/test-classes:$classpath" $classes_teste
    java -jar $dir_jacoco report ./jacoco.exec --classfiles $dir_fonte --xml $dir_xml_jacoco
    rm ./jacoco.exec
}
get_cobertura_nos()
{
    rm ./coverage.ser
    rm -r $dir_destino_epc_tool/*
    java -jar $dir_epc_tool instrument -src $dir_fonte -dest $dir_destino_epc_tool
    java -cp "$dir_epc_tool:$dir_destino_epc_tool/classes:$dir_destino_epc_tool/test-classes:$classpath" $classes_teste
    java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-node.xml
    rm ./coverage.ser
}
get_cobertura_arestas()
{
    rm ./coverage.ser
    rm -r $dir_destino_epc_tool/*
    java -jar $dir_epc_tool instrument -src $dir_fonte -dest $dir_destino_epc_tool -edges
    java -cp "$dir_epc_tool:$dir_destino_epc_tool/classes:$dir_destino_epc_tool/test-classes:$classpath" $classes_teste
    java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-edge.xml -edges
    rm ./coverage.ser
}
get_cobertura_pares_arestas()
{
    rm ./coverage.ser
    rm -r $dir_destino_epc_tool/*
    java -jar $dir_epc_tool instrument -src $dir_fonte -dest $dir_destino_epc_tool -edge-pairs
    java -cp "$dir_epc_tool:$dir_destino_epc_tool/classes:$dir_destino_epc_tool/test-classes:$classpath" $classes_teste
    java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-edge-pair.xml -edge-pairs
    rm ./coverage.ser
}
main $1 $2