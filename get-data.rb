# frozen_string_literal: true

require "json"
require "octokit"

require "./lib/conv"
require "./lib/write"

# require './secret'
# GHP = ''
# USER = ''

DATA_DIR = "data"
%x(mkdir -p #{DATA_DIR})

# OCTOKIT_ACCESS_TOKEN
client = Octokit::Client.new
# client = Octokit::Client.new(:login => 'defunkt', :password => 'personal_access_token')
client.auto_paginate = true

repos = client.repos(ENV.fetch("USER", "initdc"), query: { type: "all", sort: "pushed" })
# puts repos[0].fields
# puts repos[0].ssh_url

# repo0 = conv_key_val repos[0], :name, :clone_url
# pertty0 = JSON.pretty_generate(repo0)
# puts pertty0

repos_json = objs_conv_key_vals(repos, :name, [:ssh_url, :fork])
pretty_write "REPOS", repos_json, "data/repos.rb"

puts repos.size

# gists = client.gists
# gists.each do |gist|
#     puts gist.fields
# end

# stars = client.starred
# puts stars[0].name

# PR = client.pull_request "AdguardTeam/dnsproxy", 281
# puts PR.body
