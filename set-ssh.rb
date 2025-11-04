# frozen_string_literal: true

SSH_DIR = "#{Dir.home}/.ssh"
CONFIG = "#{Dir.home}/.ssh/config"

GIT_HOSTS = %w[
  gitea.com
  codeberg.org

  gitlab.com
  salsa.debian.org

  github.com
  bitbucket.org
  git.code.sf.net
  ssh.dev.azure.com
].freeze

def gen_sshkey(host, type = "ed25519", quiet: true)
  suffix = host.gsub(".", "-")
  keyfile = "#{Dir.home}/.ssh/id_#{type}_#{suffix}"
  pubfile = "#{Dir.home}/.ssh/id_#{type}_#{suffix}.pub"

  if File.exist?(keyfile)
    quiet = false
  end

  cmd = "ssh-keygen -t #{type} -f #{keyfile} -P ''"
  if type == "rsa"
    cmd = "ssh-keygen -t #{type} -b 4096 -f #{keyfile} -P ''"
  end

  puts cmd
  quiet ? %x(#{cmd}) : system(cmd)

  File.open(CONFIG, "a+") do |f|
    f.write "Host #{host}\n  IdentityFile #{keyfile}\n\n"
  end

  puts "------  #{pubfile}"
  puts File.read(pubfile)
  puts "------"
  puts
end

if !Dir.exist?(SSH_DIR)
  Dir.mkdir(SSH_DIR)
end

GIT_HOSTS.each do |host|
  if host != "ssh.dev.azure.com"
    gen_sshkey(host)
  else
    gen_sshkey(host, "rsa")
  end
end
