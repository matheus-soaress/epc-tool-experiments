export dir_base=/PPgSI
export dir_badua=$dir_base/ba-dua/ba-dua-cli/target/ba-dua-cli-0.7.1-SNAPSHOT-all.jar
export dir_destino_badua=$dir_base/out-badua
export dir_xml_badua=$dir_base"/reports/"$1
export classes_teste="$(defects4j export -p tests.all -w $dir_base"/projects/"$1"/"$2"b" | tr '\n' ' ')"
export classpath="$(defects4j export -p cp.test -w $dir_base"/projects/"$1"/"$2"b")"
export dir_fonte=$dir_base"/projects/"$1"/"$2"b/"
export dir_fonte_src="$(defects4j export -p dir.bin.classes -w $dir_base"/projects/"$1"/"$2"b")"
export dir_fonte_test="$(defects4j export -p dir.bin.tests -w $dir_base"/projects/"$1"/"$2"b")"
export dir_fonte_classpath="\/PPgSI\/projects\/"$1"\/"$2"b\/"
main()
{
    echo $1"-"$2"b"
    classe_junit="org.junit.runner.JUnitCore"
    case $classpath in
        *"junit-3"*)
            classe_junit="junit.textui.TestRunner"
            ;;
        *"junit-4"*)
            classe_junit="org.junit.runner.JUnitCore"
            ;;
    esac
    if [ $1 = "Compress" ]; then
        find $dir_fonte""$dir_fonte_test -maxdepth 1 ! -regex '^$dir_fonte""$dir_fonte_test"/org"' -delete
    fi
    
    get_cobertura_nos $dir_fonte_classpath $classe_junit
}
get_cobertura_nos()
{
    rm ./coverage.ser
    rm -r $dir_destino_badua/*
    java -jar $dir_badua instrument -src $dir_fonte"$dir_fonte_src" -dest $dir_destino_badua"/"$dir_fonte_src
    java -jar $dir_badua instrument -src $dir_fonte"$dir_fonte_test" -dest $dir_destino_badua"/"$dir_fonte_test
    dir_destino_badua_cp_src="/PPgSI/out-badua/"$dir_fonte_src
    dir_destino_badua_cp_test="/PPgSI/out-badua/"$dir_fonte_test
    dir_src_original=$1""$dir_fonte_src
    dir_test_original=$1""$dir_fonte_test
    classpath_badua=$(echo $classpath | sed "s,$dir_src_original,$dir_destino_badua_cp_src,g")
    classpath_badua=$(echo $classpath_badua | sed "s,$dir_test_original,$dir_destino_badua_cp_test,g")
    java -cp "$dir_badua:$classpath_badua" $2 $classes_teste
    java -jar $dir_badua report -input ./coverage.ser -classes $dir_fonte -xml $dir_xml_badua.xml
    rm ./coverage.ser
}
main $1 $2