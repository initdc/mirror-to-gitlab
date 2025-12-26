# mirror-to-gitlab

Mirror and place your codebase to other providers

## prepare

  1. create token with `RW` to `[repository, user]`

  - https://gitea.com/user/settings/applications
  - https://codeberg.org/user/settings/applications

  2. install deps

  ```sh
  # for creating repo
  eval "$(curl https://get.x-cmd.com)"
  x cb init
  x tea init

  # for exec x-cmd
  gem install cr-exec
  ```

## mirror

  1. Gen ssh keys

  ```sh
  ruby set-ssh.rb
  ```

  2. Add your public keys for git clone ssh://

  - https://github.com/settings/keys
  - https://gitlab.com/-/user_settings/ssh_keys
  - https://gitea.com/user/settings/keys
  - https://codeberg.org/user/settings/keys
  - https://bitbucket.org/account/settings/ssh-keys/

  3. edit your username `ALIAS_SSH_URL` in file push-mirror.rb

  ```sh
  OCTOKIT_ACCESS_TOKEN=ghp_xxx USER=initdc ruby get-data.rb
  ruby push-mirror.rb
  ```

## daily use 

  pushing with no bare repo

  ```sh
  ruby set-remote.rb
  ```

## License

GPL-2.0
