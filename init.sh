#!/bin/sh

echo "Installing dependencies"
python -m pip install --upgrade pip
pip install -r requirements.txt
echo "Finished installing dependencies"

echo "Running pylint checks"
pylint app
pylint tests
echo "Finished running pylint"

echo "Running mypy checks"
mypy app
mypy tests
echo "Finished running mypy"

echo "Running pytest"
pytest --cov .
echo "Finished running tests"

echo"Building Sphinx documentation"
rm -rf ./docs/*
make html
cp -r ./build/html/* ./docs/
echo "Finished building Sphinx documentation"
