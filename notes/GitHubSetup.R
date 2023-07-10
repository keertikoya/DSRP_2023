## set your name and email
usethis::use_git_config(user.name = "Keerti Koya",
                        user.email = "koyakeerti@gmail.com")

## create a personal access token (PAT) for authentication
usethis::create_github_token()

## token: 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
credentials::set_github_pat("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")