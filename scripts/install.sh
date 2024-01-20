#/bin/sh
set -eux

# Download and extract the latest afl-fuzz source package
wget http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz
tar -xvf afl-latest.tgz

rm afl-latest.tgz
cd afl-2.52b/

# Install afl-fuzz
sudo make install
cd ..
rm -rf afl-2.52b/

# Setup sharpfuzz in fuzzing directory
rm -rf ./fuzz && mkdir ./fuzz && cd ./fuzz
dotnet new console --framework net8.0
dotnet add package Jil
dotnet add package SharpFuzz
cp -r ../scripts/Program.cs .
cd ..

# Install SharpFuzz.CommandLine global .NET tool
dotnet tool install SharpFuzz.CommandLine --tool-path ~/sharpfuzz/fuzz

# To run fuzzing (in fuzz directory): pwsh ../scripts/fuzz.ps1 fuzz.csproj -i corpus