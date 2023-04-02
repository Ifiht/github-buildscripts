#!/usr/bin/env ruby
require 'csv'

# Prepare environment:
#%x(./scripts/env-setup.sh)

# Grab Google Sheets data:
%x(wget -O ./data/posts.csv 'https://docs.google.com/spreadsheets/d/1YExvb6i9T6nXvKsMbP6DDd7jonxdBPITJGvQCpHTQwI/gviz/tq?tqx=out:csv&sheet=posts')

# Clean out posts dir:
%x(rm -rf ./www/content/post/*.md)

#DEBUG
dirname = File.basename(Dir.getwd)
exec "echo #{dirname}"

# Build out each post:
CSV.foreach('./data/posts.csv', headers: true) do |row|
    puts row.inspect # debug
    post_date = Time.now.strftime('%Y-%m-%dT%H:%M:%S%:z')
    post_file = "../www/content/post/" + Time.now.strftime('%F-%H%M%S') + row["Title"].gsub(/\s+/, "") + ".md"
    #======( BEGIN FILE BUILD )=====+
    a = []
    a[0] = '---'
    a[1] = "title: \"#{row["Title"]}\""
    a[2] = "subtitle: \"#{row["Start_Date"]} - #{row["End_Date"]}\""
    a[3] = "date: #{post_date}'"
    a[4] = "summary: \" \""
    a[5] = 'draft: false'
    a[6] = '---'
    a[7] = "#{row["Post"]}"
	sleep 1
    File.open(post_file, 'w') {|f| f.write(a.join("\n"))}
end

# Execute build script:
#%x(./scripts/hugo-build.sh)
