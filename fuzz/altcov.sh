#/bin/sh -eu

num_files=$(ls corpus | wc -l)
cur_file=1

rm -rf obj bin coverage.xml __Instrumented

dotnet restore
dotnet build

/home/headshog/sharpfuzz/fuzz/altcover -i bin/Debug/net8.0 --inplace

for i in /home/headshog/YamlDotNet/fuzz/corpus/*
do
    echo "Collecting coverage of file: $cur_file/$num_files"
    /home/headshog/sharpfuzz/fuzz/altcover runner -x dotnet -l -r bin/Debug/net8.0 -- run $i --no-build
    cur_file=$((cur_file+1))
done
