name: macos

on:
  push:
    branches: [main]

  # pull_request:
  #   branches: [main]

jobs:
  macos-test:
    runs-on: macos-latest
    # if: ${{ contains(github.event.head_commit.message, "[CI]") }}

    steps:
      - uses: actions/checkout@v3

      - name: ADD SSH KEY
        env:
          SSH_KEY: ${{ secrets.ACTION_SSH }}
        run: |
          mkdir -p ~/.ssh
          echo "$SSH_KEY" | tr -d '\r' > ~/.ssh/id_ed25519
          chmod 700 ~/.ssh/id_ed25519
          eval $(ssh-agent -s)
          ssh-add ~/.ssh/id_ed25519
          ssh-keyscan -H github.com >> ~/.ssh/known_hosts

      # Error Check
      - name: Run install.sh
        run: /bin/bash ${GITHUB_WORKSPACE}/install.sh

      - name: Exec zsh
        run: |
          zsh -i -l -c exit
          zsh -i -l -c exit 2> error.log; cat error.log
          cat error.log
          if [ -s error.log ]; then false; fi

      - name: Check lazy.nvim dir
        run: ls ~/.local/share/nvim/lazy/