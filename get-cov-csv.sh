export dir_base=/PPgSI
export dir_fonte=$dir_base/projects/Csv/1b/target
export dir_jacoco=$dir_base/jacoco/org.jacoco.cli/target/org.jacoco.cli-0.8.9-SNAPSHOT-nodeps.jar
export dir_jacoco_agent=$dir_base/jacoco/org.jacoco.agent.rt/target/org.jacoco.agent.rt-0.8.9-SNAPSHOT-all.jar
export dir_destino_jacoco=$dir_base/out-jacoco
export dir_xml_jacoco=$dir_base/reports/report-csv-jacoco.xml
export dir_lib_csv=$dir_base/defects4j/framework/projects/Csv/lib
export dir_epc_tool=$dir_base/edge-pair-cov-tool/epc-tool-cli/target/epc-tool-cli-0.0.1-SNAPSHOT-all.jar
export dir_destino_epc_tool=$dir_base/out-epc-tool
export dir_xml_epc_tool=$dir_base/reports/report-csv
export classes_teste="org.junit.runner.JUnitCore org.apache.commons.csv.CSVFormatTest org.apache.commons.csv.CSVLexerTest org.apache.commons.csv.CSVParserTest org.apache.commons.csv.CSVPrinterTest org.apache.commons.csv.ExtendedBufferedReaderTest"
export classpath="$dir_lib_csv/junit/junit/4.10/junit-4.10.jar:$dir_lib_csv/org/hamcrest/hamcrest-core/1.1/hamcrest-core-1.1.jar:$dir_fonte/classes:$dir_fonte/test-classes:$dir_base/defects4j/framework/projects/lib/junit-4.11.jar:$dir_lib_csv/com/csvreader/1.0/javacsv.jar:$dir_lib_csv/com/generationjava/io/1.0/gj-csv-1.0.jar:$dir_lib_csv/com/h2database/h2/1.3.168/h2-1.3.168.jar:$dir_lib_csv/com/h2database/h2/1.4.180/h2-1.4.180.jar:$dir_lib_csv/com/h2database/h2/1.4.181/h2-1.4.181.jar:$dir_lib_csv/com/h2database/h2/1.4.182/h2-1.4.182.jar:$dir_lib_csv/com/h2database/h2/1.4.196/h2-1.4.196.jar:$dir_lib_csv/com/h2database/h2/1.4.198/h2-1.4.198.jar:$dir_lib_csv/com/opencsv/4.0/opencsv-4.0.jar:$dir_lib_csv/commons-io/commons-io/2.2/commons-io-2.2.jar:$dir_lib_csv/commons-io/commons-io/2.4/commons-io-2.4.jar:$dir_lib_csv/commons-io/commons-io/2.5/commons-io-2.5.jar:$dir_lib_csv/commons-io/commons-io/2.6/commons-io-2.6.jar:$dir_lib_csv/junit/junit/3.8.1/junit-3.8.1.jar:$dir_lib_csv/junit/junit/4.11/junit-4.11.jar:$dir_lib_csv/junit/junit/4.12/junit-4.12.jar:$dir_lib_csv/org/apache/commons/commons-lang3/3.4/commons-lang3-3.4.jar:$dir_lib_csv/org/apache/commons/commons-lang3/3.6/commons-lang3-3.6.jar:$dir_lib_csv/org/apache/commons/commons-lang3/3.7/commons-lang3-3.7.jar:$dir_lib_csv/org/apache/commons/commons-lang3/3.8.1/commons-lang3-3.8.1.jar:$dir_lib_csv/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar:$dir_lib_csv/org/mockito/mockito-all/1.10.19/mockito-all-1.10.19.jar:$dir_lib_csv/org/mockito/mockito-all/1.9.5/mockito-all-1.9.5.jar:$dir_lib_csv/org/openjdk/jmh/1.21/jmh-core-1.21.jar:$dir_lib_csv/org/skife/csv/1.0/csv-1.0.jar:$dir_lib_csv/org/supercsv/2.4.0/super-csv-2.4.0.jar"
main() 
{
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
main