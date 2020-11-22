FILES=$(git status --short | grep -E "^(A|M)" | awk '{print $2}' | xargs)
if [[ -z "$FILES" ]]; then
	exit 0
fi

WRONG_FILES=""
echo "$FILES" | while read -r LINE; do find_wrong_files "$LINE"; done

if [[ -n "${WRONG_FILES}" ]]; then
	echo "DELETE NON-TEXT FILES OR USE 'git commit -n':"
	echo -e "${WRONG_FILES}"
	echo -e "\nIf there are any mistakes, please report to https://github.com/wolfogre/git-text/issues/new"
	exit 1
fi

echo "ALL FILES ARE TEXT:"
file --mime-type ${FILES}
