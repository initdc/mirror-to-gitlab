GITHUB = 'github'
GITLAB = 'gitlab'
BITBUCKET = 'bitbucket'

def ssh_config
  `mkdir -p ~/.ssh`

  config = 'Host github.com
  IdentityFile ~/.ssh/id_ed25519_github

Host gitlab.com
  IdentityFile ~/.ssh/id_ed25519_gitlab

Host bitbucket.org
  IdentityFile ~/.ssh/id_ed25519_bitbucket'

  `echo > ~/.ssh/config '#{config}'`
end

def gen_key(suffix, type, *opt)
  bit = opt[0] || 4096
  passphrase = opt[1] || ''
  comment = opt[2]

  types = %w[dsa ecdsa ecdsa-sk ed25519 ed25519-sk rsa]
  if types.include? type
    keyfile = "~/.ssh/id_#{type}_#{suffix}"
    pubfile = "~/.ssh/id_#{type}_#{suffix}.pub"

    cmd = "ssh-keygen -t #{type} -f #{keyfile} -P '#{passphrase}'"
    cmd = "ssh-keygen -t #{type} -b #{bit} -f #{keyfile} -P '#{passphrase}'" if type == 'rsa'

    cmd += " -C #{comment}" unless comment.nil?

    puts cmd
    system cmd

    cmd = "cat #{pubfile}"
    puts "------  #{pubfile}"
    IO.popen(cmd) do |r|
      puts r.readlines
    end
    puts '------'
  else
    print 'wrong type: '
    p type
  end
end

ssh_config

gen_key GITHUB, 'ed25519'
gen_key GITLAB, 'ed25519'
gen_key BITBUCKET, 'ed25519'
