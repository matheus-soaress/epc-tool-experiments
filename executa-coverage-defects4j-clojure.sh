export dir_base=C:/Users/Adna/Documents/Matheus/Mestrado
export dir_fonte=$dir_base/Closure-1b/1b/build
export dir_jacoco=$dir_base/jacoco/org.jacoco.cli-0.8.8-nodeps.jar
export dir_jacoco_agent=$dir_base/jacoco/org.jacoco.agent-0.8.8-runtime.jar
export dir_destino_jacoco=$dir_base/ba-dua-master/jacoco
export dir_xml_jacoco=$dir_base/ba-dua-master/jacoco/report-jacoco-clojure.xml
export caminho_classe_main_jacoco=$dir_base/ba-dua-master/jacoco/classes
export caminho_classe_junit_jacoco=$dir_base/ba-dua-master/jacoco/test
export dir_m2=C:/Users/Adna/.m2/repository
export dir_epc_tool=$dir_base/ba-dua-master/ba-dua-master/epc-tool-cli/target/epc-tool-cli-0.0.1-SNAPSHOT-all.jar
export dir_destino_epc_tool=$dir_base/ba-dua-master/instrumentados
export dir_xml_epc_tool=$dir_base/ba-dua-master/instrumentados/report-clojure
export caminho_classe_main_epc_tool=$dir_base/ba-dua-master/instrumentados/classes
export caminho_classe_junit_epc_tool=$dir_base/ba-dua-master/instrumentados/test
export ferramenta_compara=$dir_base/valida-epctool-python/src/compara-report.py
export arquivo_saida_compara=$dir_base/ba-dua-master/instrumentados/comparacao-clojure
export classpath="$dir_base/Closure/1b/lib/args4j.jar;$dir_base/Closure/1b/lib/guava.jar;$dir_base/Closure/1b/lib/json.jar;$dir_base/Closure/1b/lib/jsr305.jar;$dir_base/Closure/1b/lib/protobuf-java.jar;$dir_base/Closure/1b/build/lib/rhino.jar;$dir_base/Closure/1b/lib/ant.jar;$dir_base/Closure/1b/lib/ant-launcher.jar;$dir_base/Closure/1b/lib/caja-r4314.jar;$dir_base/Closure/1b/lib/jarjar.jar;$dir_base/Closure/1b/lib/junit.jar"
export classes_teste="com.google.debugging.sourcemap.Base64Test com.google.debugging.sourcemap.Base64VLQTest com.google.debugging.sourcemap.SourceMapConsumerV1Test com.google.debugging.sourcemap.SourceMapConsumerV2Test"
rm ./jacoco.exec
rm ./coverage.ser
rm -r $caminho_classe_main_jacoco
rm -r $caminho_classe_junit_jacoco
rm -r $caminho_classe_main_epc_tool
rm -r $caminho_classe_junit_epc_tool
echo "Executando a ferramenta de cobertura JaCoCo"
java -jar $dir_jacoco instrument $dir_fonte --dest $dir_destino_jacoco
echo "Instrumentacao da JaCoCo finalizada"
echo "java -cp \"$dir_jacoco_agent;$classpath;$caminho_classe_main_jacoco;$caminho_classe_junit_jacoco\" $classes_teste"
java -cp "$dir_jacoco_agent;$classpath;$caminho_classe_main_jacoco;$caminho_classe_junit_jacoco" $classes_teste
echo "Classe instrumentada pela JaCoCo executada"
java -jar $dir_jacoco report ./jacoco.exec --classfiles $dir_fonte --xml $dir_xml_jacoco
echo "XML com relatorio da JaCoCo gerado"
pause