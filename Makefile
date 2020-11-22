build:
	cat partials/head.sh partials/func.sh partials/main.sh > pre-commit
	chmod +x pre-commit

test:
	./test.sh
