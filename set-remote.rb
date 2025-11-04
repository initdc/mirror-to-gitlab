# frozen_string_literal: true

ALIAS_SSH_URL = {
  tea: "git@gitea.com:initd/{repo}.git",
  berg: "ssh://git@codeberg.org/initd/{repo}.git",

  lab: "git@gitlab.com:initdc/{repo}.git",
  deb: "git@salsa.debian.org:o9/{repo}.git",

  hub: "git@github.com:initdc/{repo}.git",
  bit: "git@bitbucket.org:initdc/{repo}.git",
  # sf: "ssh://initd@git.code.sf.net/p/hello-sourceforge/code",
  # az: "git@ssh.dev.azure.com:v3/asia-pacific/proj/proj"
}.freeze

REPO = Dir.pwd.split("/").last

def ps(cmd)
  puts cmd
  system(cmd)
end

ALIAS_SSH_URL.each do |as, url|
  puts "----Runing for #{as} ---"
  url = url.sub("{repo}", REPO)
  ps "git remote remove #{as}"
  ps "git remote add #{as} #{url}"
  ps "git push #{as} master -f"
  puts "------------------------"
  puts
end
