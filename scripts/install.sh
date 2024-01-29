#/bin/sh
set -eux

# Setup sharpfuzz in fuzzing directory
mkdir -p ./fuzz && cd ./fuzz
dotnet new console --framework net8.0
# dotnet add package Jil
cp -r ../scripts/Program.cs .
mkdir corpus && touch corpus/1 && echo '{"menu":{"id":1,"val":"X","pop":{"a":[{"click":"Open()"},{"click":"Close()"}]}}}' > corpus/1

# Install SharpFuzz.CommandLine global .NET tool
dotnet add package SharpFuzz
dotnet tool install SharpFuzz.CommandLine --tool-path .
dotnet tool install coverlet.console --tool-path .
cd ..

# To run fuzzing (in fuzz directory): pwsh ../scripts/fuzz.ps1 fuzz.csproj -i corpus