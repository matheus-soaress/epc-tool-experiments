export dir_base=/PPgSI
export dir_fonte=$dir_base/projects/Closure/1b/build
export dir_jacoco=$dir_base/jacoco/org.jacoco.cli/target/org.jacoco.cli-0.8.9-SNAPSHOT-nodeps.jar
export dir_jacoco_agent=$dir_base/jacoco/org.jacoco.agent.rt/target/org.jacoco.agent.rt-0.8.9-SNAPSHOT-all.jar
export dir_destino_jacoco=$dir_base/out-jacoco
export dir_xml_jacoco=$dir_base/reports/report-closure-jacoco.xml
export dir_epc_tool=$dir_base/edge-pair-cov-tool/epc-tool-cli/target/epc-tool-cli-0.0.1-SNAPSHOT-all.jar
export dir_destino_epc_tool=$dir_base/out-epc-tool
export dir_xml_epc_tool=$dir_base/reports/report-closure
export caminho_classe_main_epc_tool=$dir_base/ba-dua-master/instrumentados/classes
export caminho_classe_junit_epc_tool=$dir_base/ba-dua-master/instrumentados/test
export classpath="$dir_base/Closure/1b/lib/args4j.jar;$dir_base/Closure/1b/lib/guava.jar;$dir_base/Closure/1b/lib/json.jar;$dir_base/Closure/1b/lib/jsr305.jar;$dir_base/Closure/1b/lib/protobuf-java.jar;$dir_base/Closure/1b/build/lib/rhino.jar;$dir_base/Closure/1b/lib/ant.jar;$dir_base/Closure/1b/lib/ant-launcher.jar;$dir_base/Closure/1b/lib/caja-r4314.jar;$dir_base/Closure/1b/lib/jarjar.jar;$dir_base/Closure/1b/lib/junit.jar"
export classes_teste="com.google.debugging.sourcemap.Base64Test com.google.debugging.sourcemap.Base64VLQTest com.google.debugging.sourcemap.SourceMapConsumerV1Test com.google.debugging.sourcemap.SourceMapConsumerV2Test"
rm ./jacoco.exec
rm ./coverage.ser
rm -r $dir_destino_jacoco/classes
rm -r $dir_destino_jacoco/test
rm -r $caminho_classe_main_epc_tool
rm -r $caminho_classe_junit_epc_tool
echo "Executando a ferramenta de cobertura JaCoCo"
java -jar $dir_jacoco instrument $dir_fonte --dest $dir_destino_jacoco
echo "Instrumentacao da JaCoCo finalizada"
echo "java -cp \"$dir_jacoco_agent;$classpath;$dir_destino_jacoco/classes;$dir_destino_jacoco/test\" $classes_teste"
java -cp "$dir_jacoco_agent;$classpath;$dir_destino_jacoco/classes;$dir_destino_jacoco/test" $classes_teste
echo "Classe instrumentada pela JaCoCo executada"
java -jar $dir_jacoco report ./jacoco.exec --classfiles $dir_fonte --xml $dir_xml_jacoco
echo "XML com relatorio da JaCoCo gerado"
pause