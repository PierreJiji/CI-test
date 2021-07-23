### This script contains utility functions used by both populate-clone.rb and populate-raw.rb

# Prepends a jekyll header to a file by replacing the file 
# (loops through each line to not load all of the file into memory at the same time)
def file_prepend(path, date, repoName, url)
    new_contents = ""
    str = 
    "---\n" +
    "date: #{date}\n" +
    "permalink: documentation-labs/#{repoName}/:title\n" +
    "layout: post\n" +
    "type: posts\n" +
    "project: #{repoName}\n" +
    "github: #{url}\n" +
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
def create_index(path, repoName, projectTitle, url, description)
    str = 
    "---\n" +
    "title: #{projectTitle}\n" +
    "layout: index-lab\n" +
    "project: #{repoName}\n" +
    "permalink: documentation-labs/#{repoName.gsub(' ', '-')}/\n" +
    "index: true\n" +
    "github: #{url}\n" +
    "---\n" +
    description
    
    File.open(path + "/index.md", 'w') {|f| f.write(str) }
end

def waitForInput
  puts("Waiting for input:")
  gets.chomp.upcase
end