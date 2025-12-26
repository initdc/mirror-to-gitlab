# frozen_string_literal: true

require "cr"
require "./data/repos"

ALIAS_SSH_URL = {
  tea: "git@gitea.com:initd/{repo}.git",
  berg: "ssh://git@codeberg.org/initd/{repo}.git",

  lab: "git@gitlab.com:initdc/{repo}.git",
  # deb: "git@salsa.debian.org:o9/{repo}.git",

  # tngl: "git@tangled.sh:initd.tngl.sh/{repo}",
  # bsky: "git@tangled.sh:initd.bsky.social/{repo}",
  # bit: "git@bitbucket.org:initdc/{repo}.git"
  # hub: "git@github.com:initdc/{repo}.git",
  # sf: "ssh://initd@git.code.sf.net/p/hello-sourceforge/code",
  # az: "git@ssh.dev.azure.com:v3/asia-pacific/proj/proj"
}.freeze

# cmds
CLONE_CMD = "git clone --mirror"
FETCH_CMD = "git fetch"
ADD_URL_CMD = "git remote add"
SET_URL_CMD = "git remote set-url"
PUSH_CMD = "git push --no-verify --mirror"

WORKDIR = "workdir"
%x(mkdir -p #{WORKDIR})

def ps(cmd)
  puts cmd
  Cr.answer("bash", "r+", input: cmd)
end

load_x = ". $HOME/.x-cmd.root/X\n"

Dir.chdir(WORKDIR) do
  REPOS.each do |name, data|
    is_fork = data[1]
    if is_fork
      next
    end

    dir = name.to_s
    ssh_url = data[0]

    if !Dir.exist?(dir)
      ps "#{CLONE_CMD} #{ssh_url} #{dir}"
    end

    Dir.chdir(dir) do
      ps "#{load_x} x tea repo create #{dir}"
      ps "#{load_x} x cb repo create #{dir}"

      ALIAS_SSH_URL.each do |as, url|
        puts "----Runing for #{as} ---"
        url = url.sub("{repo}", dir)
        ps "git remote remove #{as}"
        ps "git remote add #{as} #{url}"
        ps "#{PUSH_CMD} #{as} -f"
        puts "------------------------"
        puts
      end
    end

    # VPS disk space is limited
    system("rm -rf #{dir}")
  end
end
