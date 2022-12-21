export dir_base=/PPgSI
defects4j checkout -p Chart -v 1b -w $dir_base/projects/Chart/1b
defects4j compile -w $dir_base/projects/Chart/1b
defects4j checkout -p Csv -v 1b -w $dir_base/projects/Csv/1b
defects4j compile -w $dir_base/projects/Csv/1b
defects4j checkout -p Closure -v 1b -w $dir_base/projects/Closure/1b
defects4j compile -w $dir_base/projects/Closure/1b