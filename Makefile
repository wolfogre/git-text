test:
	./test.sh

build:
	cat partials/head.sh partials/func.sh partials/main.sh > pre-commit
	chmod +x pre-commit

deploy: build
	cp pre-commit .git/hooks/pre-commit

