interactive git add
`git add $(git ls-files -m -o --exclude-standard | fzf -m)`
