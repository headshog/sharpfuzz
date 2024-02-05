#/bin/sh -eu

#echo -n "{}" > coverage.json

dotnet restore
dotnet build

./minicover instrument --sources Program.cs --sources ../Jil/

num_files=$(ls corpus | wc -l)
cur_file=1

#for i in corpus/*
#do
#    echo "Collecting coverage of file: $cur_file/$num_files"
#    #./coverlet "bin/Debug/net8.0" --target "bin/Debug/net8.0/fuzz" --merge-with "coverage.json" -f json -f lcov < $i
#    dotnet run --no-build < $i
#    cur_file=$((cur_file+1))
#done

#echo "Generating html coverage"
#rm -rf coverage.lcov && mv coverage.info coverage.lcov
#genhtml -o jil-html coverage.lcov

dotnet run --no-build < corpus/1

./minicover uninstrument

echo "Generating coverage"
./minicover report --threshold 90
