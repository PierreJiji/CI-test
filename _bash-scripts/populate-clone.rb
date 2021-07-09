# This script loads all the files specified by the "path" keyword in res.yaml by cloning
# the whole project from url then moving and renaming them on the site
require 'yaml'
res = YAML.load_file('res.yaml')

res.each do |key, content|
    puts "Loading documentation from #{content["url"]}"
    puts "..."

    repoName = (content["url"].split("/")[-1]).split(".")[0] # gets exact repo name from url

    # Deletes current site folder if it existed
    system("rm -rf .._posts/documentation-labs/#{repoName}")
    system("mkdir .._posts/documentation-labs/#{repoName}")

    # Git clone the whole project
    system("git clone #{content["url"]} #{repoName}")

    # Runs through each files to be included and moves/renames them to a new folder
    for path in content["paths"] do
        fileName = path.split("/")[-1]
        dateShort = `cd #{repoName} ; git log -1 --format=%cs #{path}`.chomp() # Gets the date of the last commit on this file
        dateIso = `cd #{repoName} ; git log -1 --format=%cI #{path}`.chomp() # Gets the date of the last commit on this file Iso
        system("mv #{repoName}/#{path} .._posts/documentation-labs/#{repoName}/#{dateShort}-#{fileName}")
    end

    # Remove the cloned repo
    system("rm -rf #{repoName}")

    puts "#{repoName}\'s documentation loaded successfully!"
end