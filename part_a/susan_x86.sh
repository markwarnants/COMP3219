#!/bin/bash

echo "" > data_cache.txt
echo "" > instuction_cache.txt

for CACHE_D in 1 2 4 8 16 32 64
do
	OPTIONS_D=$CACHE_D"kB"
        echo $OPTIONS_D "data"
        ./build/X86/gem5.opt -r configs/example/se.py --l1d_size=$OPTIONS_D --cpu-type=TimingSimpleCPU --caches -c mibench/automotive/susan/susan --options "mibench/automotive/susan/input_small.pgm out.pgm"
        cat m5out/stats.txt | grep sim_insts
        cat m5out/stats.txt | grep system.cpu.numCycles

done

for CACHE_I in 1 2 4 8 16 32
do
        OPTIONS_I=$CACHE_I"kB"
        echo $OPTIONS_I "instruction"
        ./build/X86/gem5.opt -r configs/example/se.py --l1i_size=$OPTIONS_I --cpu-type=TimingSimpleCPU --caches -c mibench/automotive/susan/susan --options "mibench/automotive/susan/input_small.pgm out.pgm"
        cat m5out/stats.txt | grep sim_insts
        cat m5out/stats.txt | grep system.cpu.numCycles
done
