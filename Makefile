# Define the default target
.PHONY: all
all: install_dependencies run_pylint_checks run_pylint_checks run_pytest_tests

install_dependencies:
	python -m pip install --upgrade pip
	pip install -r requirements.txt

run_pylint_checks: install_dependencies
	pylint app
	pylint tests

run_pylint_checks: install_dependencies
	pylint app
	pylint tests

run_pytest_tests: install_dependencies
	pytest --cov .
