# mirror-to-gitlab

Mirror and place your codebase to other providers

# Use

1. Gen ssh keys

  ```sh
  ruby set-ssh.rb
  ```

2. Add your public keys

- <https://gitea.com/user/settings/keys>
- <https://codeberg.org/user/settings/keys>
- <https://gitlab.com/-/user_settings/ssh_keys>
- <https://salsa.debian.org/-/user_settings/ssh_keys>
- <https://github.com/settings/keys>
- <https://bitbucket.org/account/settings/ssh-keys/>

3. You need create repo manually for those providers which is not gitlab instance

- <https://gitea.com/repo/create>
- <https://codeberg.org/repo/create>
- <https://github.com/new>

  or you can write your logic of creating repos
  
- cli
  - <https://gitea.com/gitea/tea>
  - <https://www.x-cmd.com/mod/cb/>
  - <https://github.com/cli/cli>

4. edit your username or maybe project name in `ALIAS_SSH_URL`

  ```sh
  ruby set-remote.rb
  ```

# License

GPL-2.0
