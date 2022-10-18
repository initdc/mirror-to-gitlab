GITHUB = "github"
GITLAB = "gitlab"
JIHULAB = "jihulab"
BITBUCKET = "bitbucket"

def ssh_config
    config = 'Host github.com
  IdentityFile ~/.ssh/id_ed25519_github

Host gitlab.com
  IdentityFile ~/.ssh/id_ed25519_gitlab

Host jihulab.com
  IdentityFile ~/.ssh/id_ed25519_jihulab

Host bitbucket.org
  IdentityFile ~/.ssh/id_ed25519_bitbucket'
  
    `echo > ~/.ssh/config '#{config}'`
end

def gen_key suffix, type, *opt
    bit = opt[0] || 4096
    passphrase = opt[1] || ""
    comment = opt[2]

    types = ["dsa", "ecdsa", "ecdsa-sk", "ed25519", "ed25519-sk", "rsa"]
    if types.include? type
        keyfile = "~/.ssh/id_#{type}_#{suffix}"
        pubfile = "~/.ssh/id_#{type}_#{suffix}.pub"

        cmd = "ssh-keygen -t #{type} -f #{keyfile} -P '#{passphrase}'"
        if type == "rsa"
            cmd = "ssh-keygen -t #{type} -b #{bit} -f #{keyfile} -P '#{passphrase}'"
        end

        if comment != nil
            cmd += " -C #{comment}"
        end

        puts cmd
        system cmd
        
        cmd = "cat #{pubfile}"
        puts "------  #{pubfile}"
        IO.popen(cmd) do |r|
            puts r.readlines
        end
        puts "------"
    else
        print "wrong type: "
        p type
    end
end

ssh_config

gen_key GITHUB, "ed25519"
gen_key GITLAB, "ed25519"
gen_key JIHULAB, "ed25519"
gen_key BITBUCKET, "ed25519"