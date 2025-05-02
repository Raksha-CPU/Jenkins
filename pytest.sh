#!/bin/bash

# Set up the virtual environment
python -m venv venv
. venv/Scripts/activate

# Install required dependencies
# pip install --upgrade pip
# pip install -r dependencies.txt
pip install pytest
pip install mock
pip install pytest-html
pip install pytest-pep8
pip install pytest-cov

# Set PYTHONPATH for the src directory
export PYTHONPATH=src

# Run pytest with coverage
python -m pytest tests/test_invoice.py --cov-branch --cov-config=.coveragerc --cov-fail-under=75 --cov-report xml:cov/cov.xml --cov-report html:cov/cov_html --junitxml=reports/test/test_report.xml --cov=src --html=reports/test/test_report.html

# Extract coverage % from XML (line-rate attribute)
COVERAGE_LINE_RATE=$(grep -oP 'line-rate="\K[0-9.]+' cov/cov.xml | head -1)

# Calculate coverage percentage using Python
COVERAGE_PERCENT=$(python -c "print(round($COVERAGE_LINE_RATE * 100, 2))")

echo "Detected line coverage: $COVERAGE_PERCENT%"

# Fail if coverage is below threshold
COVERAGE_THRESHOLD=75

if (( $(echo "$COVERAGE_PERCENT < $COVERAGE_THRESHOLD" | python -c 'import sys; sys.exit(int(float(sys.argv[1]) < float(sys.argv[2])))' "$COVERAGE_PERCENT" "$COVERAGE_THRESHOLD") )); then
    echo "ERROR: Code coverage ($COVERAGE_PERCENT%) is below threshold ($COVERAGE_THRESHOLD%)."
    deactivate
    exit 1
else
    echo "Code coverage check passed: $COVERAGE_PERCENT%"
fi

# Clean up
deactivate
rm -rf test/__pycache__
# rm -rf venv
