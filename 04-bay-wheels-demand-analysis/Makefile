env:
	conda env update -f environment.yml --prune

test:
	pytest

notebooks:
	jupyter nbconvert --execute notebooks/cleaner.ipynb --to notebook --inplace
	jupyter nbconvert --execute notebooks/visualization_analysis.ipynb --to notebook --inplace
	jupyter nbconvert --execute main.ipynb --to notebook --inplace

all: test notebooks
