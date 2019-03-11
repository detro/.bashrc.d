# alias(es)
alias glog='git log --decorate=full --oneline --graph'

# Git utilities
_git_branch_depth() {
	git rev-list --count HEAD ^origin/master
}

_git_list_branch_commits() {
	local LOG_FORMAT="* (%ai) %s%n%b"
	git log --pretty="format:${LOG_FORMAT}" HEAD...HEAD~$(_git_branch_depth)
}

git_squash_branch() {
	# Refuse to work if the are local uncommitted changes
	if git diff-index --quiet HEAD; then
		COMMIT_TEMPLATE=$(mktemp)

		# Create file with commits log, before we `git reset` and lose the history
		echo "<TICKET_CODE>: <TICKET_DESCRIPTION>" >> ${COMMIT_TEMPLATE}
		echo "" >> ${COMMIT_TEMPLATE}
		_git_list_branch_commits >>  ${COMMIT_TEMPLATE}

		# Soft-reset so we can re-commit everything as a single branch
		git reset --soft HEAD~$(_git_branch_depth)

		# Commit while including the history in the body
		git commit -t ${COMMIT_TEMPLATE}

		rm ${COMMIT_TEMPLATE}
	else
		echo "Detected uncommitted changes: ABORTING!"
	fi
}



