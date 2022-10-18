require 'octokit'
require 'json'

require './lib/conv'
require './lib/write'

require './secret'
# GHP = ''
# USER = ''

DATA_DIR = "data"
`mkdir -p #{DATA_DIR}`

personal_access_token =  ENV['GHP'] || GHP
user_name = ENV['USER'] || USER

client = Octokit::Client.new(:access_token => personal_access_token)
# client = Octokit::Client.new(:login => 'defunkt', :password => 'personal_access_token')
# client.auto_paginate = true

user = client.user user_name

repos = client.repos({}, query: {type: 'all', sort: 'pushed'})
puts repos[0].fields
puts repos[0].ssh_url

# repo0 = conv_key_val repos[0], :name, :clone_url
# pertty0 = JSON.pretty_generate(repo0)
# puts pertty0

# repos_json = objs_conv_key_vals repos, :name, [:ssh_url, :fork]
# pretty_write "REPOS", repos_json, "data/repos_1.rb"

puts repos.length

# gists = client.gists
# gists.each do |gist|
#     puts gist.fields
# end

# stars = client.starred
# puts stars[0].name

# PR = client.pull_request "AdguardTeam/dnsproxy", 281
# puts PR.body