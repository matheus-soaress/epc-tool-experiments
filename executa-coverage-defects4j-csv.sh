export dir_base=C:/Users/Adna/Documents/Matheus/Mestrado
export dir_fonte=$dir_base/Csv-1b/1b/target
export dir_jacoco=$dir_base/jacoco/org.jacoco.cli-0.8.8-nodeps.jar
export dir_jacoco_agent=$dir_base/jacoco/org.jacoco.agent-0.8.8-runtime.jar
export dir_destino_jacoco=$dir_base/ba-dua-master/jacoco
export dir_xml_jacoco=$dir_base/ba-dua-master/jacoco/report-jacoco-csv.xml
export caminho_classe_main_jacoco=$dir_base/ba-dua-master/jacoco/classes
export caminho_classe_junit_jacoco=$dir_base/ba-dua-master/jacoco/test-classes
export dir_m2=C:/Users/Adna/.m2/repository
export dir_epc_tool=$dir_base/ba-dua-master/ba-dua-master/epc-tool-cli/target/epc-tool-cli-0.0.1-SNAPSHOT-all.jar
export dir_destino_epc_tool=$dir_base/ba-dua-master/instrumentados
export dir_xml_epc_tool=$dir_base/ba-dua-master/instrumentados/report-csv
export caminho_classe_main_epc_tool=$dir_base/ba-dua-master/instrumentados/classes
export caminho_classe_junit_epc_tool=$dir_base/ba-dua-master/instrumentados/test-classes
export ferramenta_compara=$dir_base/valida-epctool-python/src/compara-report.py
export arquivo_saida_compara=$dir_base/ba-dua-master/comparacao-csv
rm ./jacoco.exec
rm ./coverage.ser
rm -r $caminho_classe_main_epc_tool
rm -r $caminho_classe_junit_epc_tool
rm -r $caminho_classe_main_jacoco
rm -r $caminho_classe_junit_jacoco
echo "Executando a ferramenta de cobertura JaCoCo"
echo "Instrumentação da JaCoCo" > output-csv.txt
{ time java -jar $dir_jacoco instrument $dir_fonte --dest $dir_destino_jacoco; } 2>> output-csv.txt
echo "Instrumentacao da JaCoCo finalizada"
echo "Execução do programa instrumentado pela JaCoCo" >> output-csv.txt
{ time java -cp "$dir_jacoco_agent;$dir_m2/junit/junit/4.13.2/junit-4.13.2.jar;$dir_m2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar;$caminho_classe_main_jacoco;$caminho_classe_junit_jacoco;$dir_m2/com/csvreader/1.0/javacsv.jar;$dir_m2/genjava/gj-csv/1.0/gj-csv-1.0.jar;$dir_m2/h2database/h2/1.4.198/h2-1.4.198.jar;$dir_m2/com/opencsv/opencsv/4.0/opencsv-4.0.jar;$dir_m2/commons-io/commons-io/2.6/commons-io-2.6.jar;$dir_m2/org/apache/commons/commons-lang3/3.8.1/commons-lang3-3.8.1.jar;$dir_m2/org/mockito/mockito-all/1.10.19/mockito-all-1.10.19.jar;$dir_m2/org/openjdk/jmh/jmh-core/1.21/jmh-core-1.21.jar;$dir_m2/org/skife/kasparov/csv/1.0/csv-1.0.jar;$dir_m2/net/sf/supercsv/super-csv/2.4.0/super-csv-2.4.0.jar" org.junit.runner.JUnitCore org.apache.commons.csv.CSVFormatTest org.apache.commons.csv.CSVLexerTest org.apache.commons.csv.CSVParserTest org.apache.commons.csv.CSVPrinterTest org.apache.commons.csv.ExtendedBufferedReaderTest; } 2>> output-csv.txt
echo "Classe instrumentada pela JaCoCo executada"
echo "Geração do relatório JaCoCo" >> output-csv.txt
{ time java -jar $dir_jacoco report ./jacoco.exec --classfiles $dir_fonte --xml $dir_xml_jacoco; } 2>> output-csv.txt
echo "XML com relatorio da JaCoCo gerado"
echo "Executando a ferramenta de cobertura ba-control-flow (node coverage)"
echo "Instrumentação da ba-control-flow (node)" >> output-csv.txt
{ time java -jar $dir_epc_tool instrument -src $dir_fonte -dest $dir_destino_epc_tool; } 2>> output-csv.txt
echo "Instrumentacao (node coverage) da ba-control-flow finalizada"
echo "Execução do programa instrumentado pela ba-control-flow (node)" >> output-csv.txt
{ time java -cp "$dir_m2/junit/junit/4.13.2/junit-4.13.2.jar;$dir_m2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar;$caminho_classe_main_epc_tool;$caminho_classe_junit_epc_tool;$dir_epc_tool;$dir_m2/com/csvreader/1.0/javacsv.jar;$dir_m2/genjava/gj-csv/1.0/gj-csv-1.0.jar;$dir_m2/h2database/h2/1.4.198/h2-1.4.198.jar;$dir_m2/com/opencsv/opencsv/4.0/opencsv-4.0.jar;$dir_m2/commons-io/commons-io/2.6/commons-io-2.6.jar;$dir_m2/org/apache/commons/commons-lang3/3.8.1/commons-lang3-3.8.1.jar;$dir_m2/org/mockito/mockito-all/1.10.19/mockito-all-1.10.19.jar;$dir_m2/org/openjdk/jmh/jmh-core/1.21/jmh-core-1.21.jar;$dir_m2/org/skife/kasparov/csv/1.0/csv-1.0.jar;$dir_m2/net/sf/supercsv/super-csv/2.4.0/super-csv-2.4.0.jar" org.junit.runner.JUnitCore org.apache.commons.csv.CSVFormatTest org.apache.commons.csv.CSVLexerTest org.apache.commons.csv.CSVParserTest org.apache.commons.csv.CSVPrinterTest org.apache.commons.csv.ExtendedBufferedReaderTest; } 2>> output-csv.txt
echo "Classe instrumentada pela ba-control-flow executada"
echo "Geração do relatório ba-control-flow (node)" >> output-csv.txt
{ time java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-node.xml; } 2>> output-csv.txt
echo "XML ba-control-flow com relatorio gerado (node coverage)"
python $ferramenta_compara node $arquivo_saida_compara-node.txt $dir_xml_epc_tool-node.xml $dir_xml_jacoco
pause
rm ./coverage.ser
rm -r $caminho_classe_main_epc_tool
rm -r $caminho_classe_junit_epc_tool
echo "Executando a ferramenta de cobertura ba-control-flow (edge coverage)"
echo "Instrumentação da ba-control-flow (edge)" >> output-csv.txt
{ time java -jar $dir_epc_tool instrument -src $dir_fonte -dest $dir_destino_epc_tool -edges; } 2>> output-csv.txt
echo "Instrumentacao (edge coverage) da ba-control-flow finalizada"
echo "Execução do programa instrumentado pela ba-control-flow (edge)" >> output-csv.txt
{ time java -cp "$dir_epc_tool;$dir_m2/junit/junit/4.13.2/junit-4.13.2.jar;$dir_m2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar;$caminho_classe_main_epc_tool;$caminho_classe_junit_epc_tool;$dir_m2/com/csvreader/1.0/javacsv.jar;$dir_m2/genjava/gj-csv/1.0/gj-csv-1.0.jar;$dir_m2/h2database/h2/1.4.198/h2-1.4.198.jar;$dir_m2/com/opencsv/opencsv/4.0/opencsv-4.0.jar;$dir_m2/commons-io/commons-io/2.6/commons-io-2.6.jar;$dir_m2/org/apache/commons/commons-lang3/3.8.1/commons-lang3-3.8.1.jar;$dir_m2/org/mockito/mockito-all/1.10.19/mockito-all-1.10.19.jar;$dir_m2/org/openjdk/jmh/jmh-core/1.21/jmh-core-1.21.jar;$dir_m2/org/skife/kasparov/csv/1.0/csv-1.0.jar;$dir_m2/net/sf/supercsv/super-csv/2.4.0/super-csv-2.4.0.jar" org.junit.runner.JUnitCore org.apache.commons.csv.CSVFormatTest org.apache.commons.csv.CSVLexerTest org.apache.commons.csv.CSVParserTest org.apache.commons.csv.CSVPrinterTest org.apache.commons.csv.ExtendedBufferedReaderTest; } 2>> output-csv.txt
echo "Classe instrumentada pela ba-control-flow executada"
echo "Geração do relatório ba-control-flow (edge)" >> output-csv.txt
{ time java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-edge.xml -edges; } 2>> output-csv.txt
echo "XML ba-control-flow com relatorio gerado (edge coverage)"
python $ferramenta_compara edge $arquivo_saida_compara-edge.txt $dir_xml_epc_tool-edge.xml $dir_xml_jacoco
pause
rm ./coverage.ser
rm -r $caminho_classe_main_epc_tool
rm -r $caminho_classe_junit_epc_tool
echo "Executando a ferramenta de cobertura ba-control-flow (edge-pair coverage)"
echo "Instrumentação da ba-control-flow (edge-pair)" >> output-csv.txt
{ time java -jar $dir_epc_tool instrument -src $dir_fonte -dest $dir_destino_epc_tool -edge-pairs; } 2>> output-csv.txt
echo "Instrumentacao (edge-pair coverage) da ba-control-flow finalizada"
echo "Execução do programa instrumentado pela ba-control-flow (edge-pair)" >> output-csv.txt
{ time java -cp "$dir_epc_tool;$dir_m2/junit/junit/4.13.2/junit-4.13.2.jar;$dir_m2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar;$caminho_classe_main_epc_tool;$caminho_classe_junit_epc_tool;$dir_m2/com/csvreader/1.0/javacsv.jar;$dir_m2/genjava/gj-csv/1.0/gj-csv-1.0.jar;$dir_m2/h2database/h2/1.4.198/h2-1.4.198.jar;$dir_m2/com/opencsv/opencsv/4.0/opencsv-4.0.jar;$dir_m2/commons-io/commons-io/2.6/commons-io-2.6.jar;$dir_m2/org/apache/commons/commons-lang3/3.8.1/commons-lang3-3.8.1.jar;$dir_m2/org/mockito/mockito-all/1.10.19/mockito-all-1.10.19.jar;$dir_m2/org/openjdk/jmh/jmh-core/1.21/jmh-core-1.21.jar;$dir_m2/org/skife/kasparov/csv/1.0/csv-1.0.jar;$dir_m2/net/sf/supercsv/super-csv/2.4.0/super-csv-2.4.0.jar" org.junit.runner.JUnitCore org.apache.commons.csv.CSVFormatTest org.apache.commons.csv.CSVLexerTest org.apache.commons.csv.CSVParserTest org.apache.commons.csv.CSVPrinterTest org.apache.commons.csv.ExtendedBufferedReaderTest; } 2>> output-csv.txt
echo "Classe instrumentada pela ba-control-flow executada"
echo "Geração do relatório ba-control-flow (edge-pair)" >> output-csv.txt
{ time java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-edge-pair.xml -edge-pairs; } 2>> output-csv.txt
echo "XML ba-control-flow com relatorio gerado (edge-pair coverage)"
pause