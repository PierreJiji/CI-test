# This script loads all the files specified by the "path" keyword in res.yaml by cloning
# the whole project from url then moving and renaming them on the site
require 'yaml'

# Main script
def main
    res = YAML.load_file('res.yaml')

    res.each do |key, content|
        puts "Loading documentation from #{content["url"]}"
        puts "..."
    
        repoName = (content["url"].split("/")[-1]).split(".")[0] # gets exact repo name from url

        # Deletes current site folder if it existed
        system("rm -rf ../_documentation-labs/#{repoName}")
        system("mkdir ../_documentation-labs/#{repoName}")

        # Git clone the whole project
        system("rm -rf #{repoName}")
        system("git clone #{content["url"]} #{repoName}")
    
        # Runs through each files to be included and moves/renames them to a new folder
        for path in content["paths"] do
            fileName = path.split("/")[-1]
            dateShort = `cd #{repoName} ; git log -1 --format=%cs #{path}`.chomp() # Gets the date of the last commit on this file
            dateIso = `cd #{repoName} ; git log -1 --format=%cI #{path}`.chomp() # Gets the date of the last commit on this file Iso format
            file_prepend("#{repoName}/#{path}", dateIso, "#{repoName}")
            system("mv #{repoName}/#{path} ../_documentation-labs/#{repoName}/#{dateShort}-#{fileName}")
            create_index("../_documentation-labs/#{repoName}", "#{repoName}", "#{content["project-title"]}")
        end
    
        # Remove the cloned repo
        system("rm -rf #{repoName}")
    
        puts "#{repoName}\'s documentation loaded successfully!"
    end 
end

# Prepends a jekyll header to a file by replacing the file 
# (loops through each line to not load all of the file into memory at the same time)
def file_prepend(path, date, repoName)
    new_contents = ""
    str = 
    "---\n" +
    "date: #{date}\n" +
    "permalink: documentation-labs/#{repoName}/:title\n" +
    "layout: post\n" +
    "type: posts\n" +
    "project: #{repoName}\n" +
    "index: false\n" +
    "---\n"
    File.open(path, 'r') do |fd|
      contents = fd.read
      new_contents = str << contents
    end
    # Overwrite file but now with prepended string on it
    File.open(path, 'w') do |fd| 
      fd.write(new_contents)
    end
end

# Creates an index for the project, which will list and reference the different docs of the project
def create_index(path, repoName, projectTitle)
    str = 
    "---\n" +
    "title: #{projectTitle}\n" +
    "layout: index-lab\n" +
    "project: #{repoName}\n" +
    "permalink: documentation-labs/#{repoName.gsub(' ', '-')}/\n" +
    "index: true\n" +
    "---"
    File.open(path + "/index.md", 'w') {|f| f.write(str) }
end

main