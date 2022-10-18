require "./data/repos"

# origin
ORIGIN = "origin"
UPSTREAM = "upstream"

GITHUB = "github"
GITLAB = "gitlab"
JIHULAB = "jihulab"
BITBUCKET = "bitbucket"

# ssh
GITHUB_SSH = "git@github.com"
GITLAB_SSH = "git@gitlab.com"
JIHULAB_SSH = "git@jihulab.com"
BITBUCKET_SSH = "git@bitbucket.org"

# user
GITHUB_USER = "initdc"
GITLAB_USER = "initdc"
JIHULAB_USER = "fi"
BITBUCKET_USER = "initdc"

# https
GITHUB_HTTPS = "https://github.com"
GITLAB_HTTPS = "https://gitlab.com"
JIHULAB_HTTPS = "https://jihulab.com"
BITBUCKET_HTTPS = "https://#{BITBUCKET_USER}@bitbucket.org"

# cmds
CLONE_CMD = "git clone --mirror"
FETCH_CMD = "git fetch"
ADD_URL_CMD = "git remote add"
SET_URL_CMD = "git remote set-url"
PUSH_CMD = "git push --no-verify --mirror"

WORKDIR = "workdir"
`mkdir -p #{WORKDIR}`

def replace_url url, old_str, new_str
    if url.include? old_str
        return url.sub old_str, new_str
    else
        print "url not include: "
        p old_str
        return nil
    end
end

def dir_exist? dir
    if system "test -d #{dir}"
        return true
    else
        return false
    end
end

def catch_run cmd
    result = system cmd
    if not result
        return
    end
end

Dir.chdir WORKDIR do
    REPOS.each do | name, data |
        dir = "#{name}"
        ssh_url = data[0]
        is_fork = data[1]

        gl_url = replace_url ssh_url, "#{GITHUB_SSH}:#{GITHUB_USER}", "#{GITLAB_SSH}:#{GITLAB_USER}"
        if not gl_url.nil?
            puts gl_url
            if not dir_exist? dir
                catch_run "#{CLONE_CMD} #{ssh_url} #{dir}"
                Dir.chdir dir do
                    catch_run "#{ADD_URL_CMD} #{GITLAB} #{gl_url}"
                    catch_run "#{PUSH_CMD} #{GITLAB}"
                end
            else
                Dir.chdir dir do
                    catch_run "#{SET_URL_CMD} #{ORIGIN} #{ssh_url}"
                    catch_run "#{FETCH_CMD} #{ORIGIN}"
                    catch_run "#{SET_URL_CMD} #{GITLAB} #{gl_url}"
                    catch_run "#{PUSH_CMD} #{GITLAB}"
                end
            end
        end
    end
end