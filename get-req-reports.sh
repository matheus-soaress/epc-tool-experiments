export dir_report=/PPgSI/reports/
# Jacoco
egrep '</package><counter.*/report>' -o "$dir_report"*-jacoco.xml | grep -E  '((^[^:]*)|("CLASS"[^"]*"[^\/]*"))' -o >> "$dir_report"class-cov-jacoco.txt
egrep '</package><counter.*/report>' -o "$dir_report"*-jacoco.xml | grep -E  '((^[^:]*)|("METHOD"[^"]*"[^\/]*"))' -o >> "$dir_report"method-cov-jacoco.txt
egrep '</package><counter.*/report>' -o "$dir_report"*-jacoco.xml | grep -E  '((^[^:]*)|("COMPLEXITY"[^"]*"[^\/]*"))' -o >> "$dir_report"complex-cov-jacoco.txt
egrep '</package><counter.*/report>' -o "$dir_report"*-jacoco.xml | grep -E  '((^[^:]*)|("LINE"[^"]*"[^\/]*"))' -o >> "$dir_report"line-cov-jacoco.txt
egrep '</package><counter.*/report>' -o "$dir_report"*-jacoco.xml | grep -E  '((^[^:]*)|("BRANCH"[^"]*"[^\/]*"))' -o >> "$dir_report"branch-cov-jacoco.txt
egrep '</package><counter.*/report>' -o "$dir_report"*-jacoco.xml | grep -E  '((^[^:]*)|("INSTRUCTION"[^"]*"[^\/]*"))' -o >> "$dir_report"instr-cov-jacoco.txt
# Node
egrep '</class><counter.*/report>' -o "$dir_report"*-node.xml | grep -E  '((^[^:]*)|("CLASS"[^"]*"[^\/]*"))' -o >> "$dir_report"class-cov-node.txt
egrep '</class><counter.*/report>' -o "$dir_report"*-node.xml | grep -E  '((^[^:]*)|("METHOD"[^"]*"[^\/]*"))' -o >> "$dir_report"method-cov-node.txt
egrep '</class><counter.*/report>' -o "$dir_report"*-node.xml | grep -E  '((^[^:]*)|("NODE"[^"]*"[^\/]*"))' -o >> "$dir_report"node-cov-node.txt
egrep '</class><counter.*/report>' -o "$dir_report"*-node.xml | grep -E  '((^[^:]*)|("LINE"[^"]*"[^\/]*"))' -o >> "$dir_report"line-cov-node.txt
# Edge
egrep '</class><counter.*/report>' -o "$dir_report"*-edge.xml | grep -E  '((^[^:]*)|("CLASS"[^"]*"[^\/]*"))' -o >> "$dir_report"class-cov-edge.txt
egrep '</class><counter.*/report>' -o "$dir_report"*-edge.xml | grep -E  '((^[^:]*)|("METHOD"[^"]*"[^\/]*"))' -o >> "$dir_report"method-cov-edge.txt
egrep '</class><counter.*/report>' -o "$dir_report"*-edge.xml | grep -E  '((^[^:]*)|("EDGE"[^"]*"[^\/]*"))' -o >> "$dir_report"edge-cov-edge.txt
# Edge-pair
egrep '</class><counter.*/report>' -o "$dir_report"*-edge-pair.xml | grep -E  '((^[^:]*)|("CLASS"[^"]*"[^\/]*"))' -o >> "$dir_report"class-cov-edge-pair.txt
egrep '</class><counter.*/report>' -o "$dir_report"*-edge-pair.xml | grep -E  '((^[^:]*)|("METHOD"[^"]*"[^\/]*"))' -o >> "$dir_report"method-cov-edge-pair.txt
egrep '</class><counter.*/report>' -o "$dir_report"*-edge-pair.xml | grep -E  '((^[^:]*)|("EDGE-PAIR"[^"]*"[^\/]*"))' -o >> "$dir_report"edge-pair-cov-edge-pair.txt