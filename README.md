# mirror-to-gitlab

Mirror and place your codebase to other providers

## prepare

  1. create token with `RW` to `[repository, user]`

  - https://codeberg.org/user/settings/applications
  - https://gitea.com/user/settings/applications

  2. install deps

  ```sh
  # for creating repo
  eval "$(curl https://get.x-cmd.com)"
  x cb init
  x tea init

  # for exec x-cmd
  sudo gem install cr-exec octokit faraday-retry
  ```

## mirror

  1. Gen ssh keys

  ```sh
  ruby set-ssh.rb
  ```

  2. Add your public keys for git clone ssh://

  - https://github.com/settings/keys
  - https://gitlab.com/-/user_settings/ssh_keys
  - https://codeberg.org/user/settings/keys
  - https://gitea.com/user/settings/keys
  - https://bitbucket.org/account/settings/ssh-keys/

  3. edit your username in files `get-data.rb` `push-mirror.rb`

  ```sh
  OCTOKIT_ACCESS_TOKEN=ghp_xxx ruby get-data.rb
  ruby push-mirror.rb
  ```

## daily use 

  pushing with no bare repo

  ```sh
  ln set-remote.rb ~/bin/set-remote.rb
  set-remote.rb
  ```

## License

GPL-2.0
