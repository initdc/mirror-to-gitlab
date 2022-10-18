def pretty_write key, json, filename
    buf = "#{key} = "
    pretty = JSON.pretty_generate json
    puts pretty
    buf += pretty.to_s
    `echo > #{filename} '#{buf}'`
end