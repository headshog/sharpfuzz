#/bin/sh -eu

echo -n "{}" > coverage.json

num_files=$(ls corpus | wc -l)
cur_file=1

rm -rf obj bin coverage.json coverage-hits ../coverage.json ../coverage-hits

dotnet restore
dotnet build

# If something went wrong, need to rebuild Jil
./minicover instrument --workdir / --sources "/home/headshog/Jil/" --sources "/home/headshog/sharpfuzz/fuzz/Program.cs" \
     --assemblies "/home/headshog/sharpfuzz/fuzz/**/*.dll" \
    --coverage-file "/home/headshog/sharpfuzz/fuzz/coverage.json" --hits-directory "/home/headshog/sharpfuzz/fuzz/coverage-hits"

./minicover reset --workdir / --hits-directory "/home/headshog/sharpfuzz/fuzz/coverage-hits"

for i in corpus/*
do
    echo "Collecting coverage of file: $cur_file/$num_files"
    dotnet run --no-build < $i
    cur_file=$((cur_file+1))
done

./minicover uninstrument --workdir / --coverage-file "/home/headshog/sharpfuzz/fuzz/coverage.json"

echo "Generating coverage"
./minicover report --threshold 90 --no-fail --workdir / --coverage-file "/home/headshog/sharpfuzz/fuzz/coverage.json"
