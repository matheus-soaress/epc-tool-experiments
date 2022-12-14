export dir_base=C:/Users/Adna/Documents/Matheus/Mestrado
export dir_fonte=$dir_base/Chart-1b/1b
export dir_jacoco=$dir_base/jacoco/org.jacoco.cli-0.8.8-nodeps.jar
export dir_jacoco_agent=$dir_base/jacoco/org.jacoco.agent-0.8.8-runtime.jar
export dir_destino_jacoco=$dir_base/ba-dua-master/jacoco
export dir_xml_jacoco=$dir_base/ba-dua-master/jacoco/report-jacoco-chart.xml
export caminho_classe_main_jacoco=$dir_base/ba-dua-master/jacoco/build
export caminho_classe_junit_jacoco=$dir_base/ba-dua-master/jacoco/build-tests
export dir_m2=C:/Users/Adna/.m2/repository
export dir_epc_tool=$dir_base/ba-dua-master/ba-dua-master/epc-tool-cli/target/epc-tool-cli-0.0.1-SNAPSHOT-all.jar
export dir_destino_epc_tool=$dir_base/ba-dua-master/instrumentados
export dir_xml_epc_tool=$dir_base/ba-dua-master/instrumentados/report-chart
export caminho_classe_main_epc_tool=$dir_base/ba-dua-master/instrumentados/build
export caminho_classe_junit_epc_tool=$dir_base/ba-dua-master/instrumentados/build-tests
export ferramenta_compara=$dir_base/valida-epctool-python/src/compara-report.py
export arquivo_saida_compara=$dir_base/ba-dua-master/comparacao-chart
export classes_teste="org.jfree.chart.junit.JFreeChartTestSuite org.jfree.chart.annotations.junit.AnnotationsPackageTests org.jfree.chart.axis.junit.AxisPackageTests org.jfree.chart.axis.junit.LogarithmicAxisTests org.jfree.chart.axis.junit.SegmentedTimelineTests org.jfree.chart.block.junit.BlockPackageTests org.jfree.data.time.junit.DataTimePackageTests org.jfree.chart.entity.junit.EntityPackageTests org.jfree.chart.imagemap.junit.ImageMapPackageTests org.jfree.chart.labels.junit.LabelsPackageTests org.jfree.chart.labels.junit.StandardPieSectionLabelGeneratorTests org.jfree.chart.needle.junit.NeedlePackageTests org.jfree.chart.plot.dial.junit.DialPackageTests org.jfree.chart.plot.junit.PlotPackageTests org.jfree.chart.renderer.category.junit.RendererCategoryPackageTests org.jfree.chart.renderer.xy.junit.RendererXYPackageTests org.jfree.chart.title.junit.TitlePackageTests org.jfree.chart.urls.junit.UrlsPackageTests org.jfree.chart.util.junit.UtilPackageTests org.jfree.data.category.junit.DataCategoryPackageTests org.jfree.data.function.junit.DataFunctionPackageTests org.jfree.data.gantt.junit.DataGanttPackageTests org.jfree.data.general.junit.DataGeneralPackageTests org.jfree.data.general.junit.DefaultHeatMapDatasetTests org.jfree.data.junit.DataPackageTests org.jfree.data.junit.DataUtilitiesTests org.jfree.data.statistics.junit.DataStatisticsPackageTests org.jfree.data.time.junit.DataTimePackageTests org.jfree.data.time.ohlc.junit.OHLCPackageTests org.jfree.data.xy.junit.DataXYPackageTests"
rm ./jacoco.exec
rm ./coverage.ser
rm -r $dir_destino_epc_tool/build
rm -r $dir_destino_epc_tool/build-tests
rm -r $dir_destino_jacoco/build
rm -r $dir_destino_jacoco/build-tests
echo "Executando a ferramenta de cobertura JaCoCo"
echo "Instrumentação da JaCoCo" > output-chart.txt
{ time java -jar $dir_jacoco instrument $dir_fonte/build --dest $dir_destino_jacoco/build; } 2>> output-chart.txt
{ time java -jar $dir_jacoco instrument $dir_fonte/build-tests --dest $dir_destino_jacoco/build-tests; } 2>> output-chart.txt
echo "Instrumentação da JaCoCo finalizada"
echo "Execução do programa instrumentado pela JaCoCo" >> output-chart.txt
{ time java -cp "C:/Program Files/Java/jdk1.8.0_301/jre/lib;$dir_jacoco_agent;$dir_destino_jacoco/build;$dir_destino_jacoco/build-tests;$dir_m2/junit/junit/4.11/junit-4.11.jar;$dir_m2/org/eclipse/swt/org.eclipse.swt.win32.win32.x86_64/4.3/org.eclipse.swt.win32.win32.x86_64-4.3.jar;$dir_m2/org/jfree/jfreechart/1.5.0/jfreechart-1.5.0.jar;$dir_fonte/lib/iText-2.1.4.jar;$dir_fonte/lib/junit.jar;$dir_fonte/lib/servlet.jar;" $classes_teste; } 2>> output-chart.txt
echo "Classe instrumentada pela JaCoCo executada"
echo "Geração do relatório JaCoCo" >> output-chart.txt
{ time java -jar $dir_jacoco report ./jacoco.exec --classfiles $dir_fonte/build --classfiles $dir_fonte/build-tests --xml $dir_xml_jacoco; } 2>> output-chart.txt
echo "XML com relatorio gerado"
echo "Executando a ferramenta de cobertura ba-control-flow (node coverage)"
echo "Instrumentação da ba-control-flow (node)" >> output-chart.txt
{ time java -jar $dir_epc_tool instrument -src $dir_fonte/build -dest $dir_destino_epc_tool/build; } 2>> output-chart.txt
{ time java -jar $dir_epc_tool instrument -src $dir_fonte/build-tests -dest $dir_destino_epc_tool/build-tests; } 2>> output-chart.txt
echo "Instrumentacao da ba-control-flow finalizada (node coverage)"
echo "Execução do programa instrumentado pela ba-control-flow (node)" >> output-chart.txt
{ time java -cp "C:/Program Files/Java/jdk1.8.0_301/jre/lib;$dir_epc_tool;$dir_destino_epc_tool/build;$dir_destino_epc_tool/build-tests;$dir_m2/junit/junit/4.11/junit-4.11.jar;$dir_m2/org/eclipse/swt/org.eclipse.swt.win32.win32.x86_64/4.3/org.eclipse.swt.win32.win32.x86_64-4.3.jar;$dir_m2/org/jfree/jfreechart/1.5.0/jfreechart-1.5.0.jar;$dir_fonte/lib/iText-2.1.4.jar;$dir_fonte/lib/junit.jar;$dir_fonte/lib/servlet.jar;" $classes_teste; } 2>> output-chart.txt
echo "Classe instrumentada pela ba-control-flow executada (node coverage)"
echo "Geração do relatório ba-control-flow (node)" >> output-chart.txt
{ time java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-node.xml; } 2>> output-chart.txt
echo "XML ba-control-flow com relatorio gerado (node coverage)"
python $ferramenta_compara node $arquivo_saida_compara-node.txt $dir_xml_epc_tool-node.xml $dir_xml_jacoco
pause
rm ./coverage.ser
rm -r $dir_destino_epc_tool/build
rm -r $dir_destino_epc_tool/build-tests
echo "Executando a ferramenta de cobertura ba-control-flow (edge coverage)"
echo "Instrumentação da ba-control-flow (edge)" >> output-chart.txt
{ time java -jar $dir_epc_tool instrument -src $dir_fonte/build -dest $dir_destino_epc_tool/build -edges; } 2>> output-chart.txt
{ time java -jar $dir_epc_tool instrument -src $dir_fonte/build-tests -dest $dir_destino_epc_tool/build-tests -edges; } 2>> output-chart.txt
echo "Instrumentacao da ba-control-flow finalizada (edge coverage)"
echo "Execução do programa instrumentado pela ba-control-flow (edge)" >> output-chart.txt
{ time java -cp "C:/Program Files/Java/jdk1.8.0_301/jre/lib;$dir_epc_tool;$dir_destino_epc_tool/build;$dir_destino_epc_tool/build-tests;$dir_m2/junit/junit/4.11/junit-4.11.jar;$dir_m2/org/eclipse/swt/org.eclipse.swt.win32.win32.x86_64/4.3/org.eclipse.swt.win32.win32.x86_64-4.3.jar;$dir_m2/org/jfree/jfreechart/1.5.0/jfreechart-1.5.0.jar;$dir_fonte/lib/iText-2.1.4.jar;$dir_fonte/lib/junit.jar;$dir_fonte/lib/servlet.jar;" $classes_teste; } 2>> output-chart.txt
echo "Classe instrumentada pela ba-control-flow executada (edge coverage)"
echo "Geração do relatório ba-control-flow (edge)" >> output-chart.txt
{ time java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-edge.xml -edges; } 2>> output-chart.txt
echo "XML ba-control-flow com relatorio gerado (edge coverage)"
python $ferramenta_compara edge $arquivo_saida_compara-edge.txt $dir_xml_epc_tool-edge.xml $dir_xml_jacoco
pause
rm ./coverage.ser
rm -r $dir_destino_epc_tool/build
rm -r $dir_destino_epc_tool/build-tests
echo "Executando a ferramenta de cobertura ba-control-flow (edge-pair coverage)"
echo "Instrumentação da ba-control-flow (edge-pair)" >> output-chart.txt
{ time java -jar $dir_epc_tool instrument -src $dir_fonte/build -dest $dir_destino_epc_tool/build -edge-pairs; } 2>> output-chart.txt
{ time java -jar $dir_epc_tool instrument -src $dir_fonte/build-tests -dest $dir_destino_epc_tool/build-tests -edge-pairs; } 2>> output-chart.txt
echo "Instrumentacao da ba-control-flow finalizada (edge-pair coverage)"
echo "Execução do programa instrumentado pela ba-control-flow (edge-pair)" >> output-chart.txt
{ time java -cp "C:/Program Files/Java/jdk1.8.0_301/jre/lib;$dir_epc_tool;$dir_destino_epc_tool/build;$dir_destino_epc_tool/build-tests;$dir_m2/junit/junit/4.11/junit-4.11.jar;$dir_m2/org/eclipse/swt/org.eclipse.swt.win32.win32.x86_64/4.3/org.eclipse.swt.win32.win32.x86_64-4.3.jar;$dir_m2/org/jfree/jfreechart/1.5.0/jfreechart-1.5.0.jar;$dir_fonte/lib/iText-2.1.4.jar;$dir_fonte/lib/junit.jar;$dir_fonte/lib/servlet.jar;" $classes_teste; } 2>> output-chart.txt
echo "Classe instrumentada pela ba-control-flow executada (edge-pair coverage)"
echo "Geração do relatório ba-control-flow (edge-pair)" >> output-chart.txt
{ time java -jar $dir_epc_tool report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_epc_tool-edge-pair.xml -edge-pairs; } 2>> output-chart.txt
echo "XML ba-control-flow com relatorio gerado (edge-pair coverage)"
pause