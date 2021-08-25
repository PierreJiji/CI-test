### This script contains utility functions used by populate-raw.rb

# Looks for the links in the document and checks if they are relative paths instead of direct url
def broken_links(file, repoUrl)
  scan = file.scan(/\[.*?\]\([^#].*?\)/) # checks for [link](text) format (and not [link](#text))
  for elem in scan do
    if (!elem.include?("http"))
      link = elem[/(?<=\().*(?=\))/] # get the text in between []
      text = elem[/(?<=\[).*(?=\])/] # get the text in between ()
      newlink = repoUrl + link
      puts "broken link found, automatically replacing \"#{link}\" with \"#{newlink}\"\n".cyan
      link = link.gsub(/(?=\W)/, "\\") # makes the string regex friendly
      file = file.gsub(/(?<=\[)#{link}(?=\]\([^#].*?\))/, newlink) # replaces the link of a [link](text) format
    end
  end
  return file
end

# Prepends a jekyll header to a file by replacing the file, iterating through each line and checking for broken links
# (loops through each line to not load all of the lines into memory at the same time)
def process_file(path, date, repoName, url, repoUrl)
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
      contents = broken_links(fd.read, repoUrl)
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
  index = ARGV.find_index("--secret")

  if (index && ARGV[index+1]) # --secret 12345
    puts "Using secret from provided argument".cyan
    secret = ARGV[index+1].delete("\n")

  elsif (index && !ARGV[index+1]) # --secret
    puts "Please respect the argument syntax of --secret <your_secret>".red
    abort
  
  elsif (ENV["API_TOKEN"]) # fetches env variable
    puts "Using secret from environment variable".cyan
    secret = ENV["API_TOKEN"]

  else # no arguments
    puts "Fetching API key from local files...".yellow
    secret = strVar = File.open('secret') {|f| f.readline}
    secret = secret.delete("\n")
  end

  return secret
end