#!/usr/bin/env bash
set -euo pipefail

# Always work from this script's directory
cd "$(dirname "$0")"

INPUT_DIR="input_files"
OUTPUT_DIR="output_files"

# Make sure output directory exists
mkdir -p "$OUTPUT_DIR"

# List of scheduler executables to run
schedulers=(RR EP EP_RR)

for input in "$INPUT_DIR"/*.txt; do
    # Handle case where there are no .txt files
    [ -e "$input" ] || continue

    base="$(basename "$input" .txt)"

    echo "=== Running all schedulers on $input ==="

    for sched in "${schedulers[@]}"; do
        if [[ ! -x "./$sched" ]]; then
            echo "  [SKIP] $sched not found or not executable"
            continue
        fi

        echo "  -> $sched"

        # Run scheduler: it will write execution.txt in the project root
        "./$sched" "$input"

        # Copy/rename execution.txt into output_files with a unique name
        cp "execution.txt" "$OUTPUT_DIR/${base}_${sched}.txt"
    done

    echo
done

echo "Done. Check the '$OUTPUT_DIR' folder for results."
