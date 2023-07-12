## set your name and email
usethis::use_git_config(user.name = "Keerti Koya",
                        user.email = "koyakeerti@gmail.com")

## create a personal access token (PAT) for authentication
usethis::create_github_token()

#credentials::set_github_pat("")

# git config --global --edit 
  # gets rid of git@github.com: and gets https