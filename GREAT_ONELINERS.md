# Commands
A list of smart commands I've created or "stolen".
## Git
interactive git add. Think I created this.
`git add $(git ls-files -m -o --exclude-standard | fzf -m)`
latest commit
found somewhere on stack overflow.
`git for-each-ref --sort=committerdate refs/heads/ refs/remotes --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))' --color=always`
