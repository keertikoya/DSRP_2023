## set your name and email
usethis::use_git_config(user.name = "Keerti Koya",
                        user.email = "koyakeerti@gmail.com")

## create a personal access token (PAT) for authentication
usethis::create_github_token()

## token: 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
credentials::set_github_pat("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")

# git config --global --edit 
  # gets rid of git@github.com: and gets https