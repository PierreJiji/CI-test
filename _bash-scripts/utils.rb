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
def create_index(path, repoName, projectTitle, url, description, repoDate)
    str = 
    "---\n" +
    "title: #{projectTitle}\n" +
    "layout: index-lab\n" +
    "project: #{repoName}\n" +
    "permalink: documentation-labs/#{repoName.gsub(' ', '-')}/\n" +
    "index: true\n" +
    "github: #{url}\n" +
    "date: #{repoDate}\n" +
    "---\n" +
    description
    
    File.open(path + "/index.md", 'w') {|f| f.write(str) }
end

def waitForInput
  puts("Waiting for input:")
  gets.chomp.upcase
end

# Checks if secret exist and if not prompts the user to enter one
# Returns the fetched secret
def check_secret
  secret = "" # Put your own secret here
  index = ARGV.find_index("--secret")

  if (index && argvs[index+1]) # --secret 12345
    secret = argvs[index+1].delete("\n")
    # export GITHUB_SECRET=secret
    puts "Secret successfully updated".green

  elsif (index && !argvs[index+1]) # --secret
    puts "Please respect the syntax of --secret <your_secret>".red
    abort

  elsif (secret=="") # no arguments but missing api key
    puts "You do not have a github secret key set, please paste your github API key here: ".yellow
    argvCopy = ARGV.map(&:clone)
    ARGV.clear # needs to be cleared to be able to use get.chomp
    secret = gets.chomp.delete("\n")
    # export GITHUB_SECRET=secret
    ARGV.replace argvCopy # reset args
    puts "Secret set! You can always set a new github API key by calling this script with the --secret <your_token> argument".green
  end
  puts secret
  return secret
end