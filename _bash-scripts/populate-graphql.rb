# This script loads all the files specified by the "path" keyword in res.yaml by cloning
# the whole project from url then moving and renaming them on the site
# option: --trace to get full exception error messages
require 'yaml'
require_relative 'utils'
require 'colorize'
require 'json'
require 'cgi'

# Main script
def main
    secret = check_secret()
    
    trace = ARGV.include? "--trace"
    puts trace

    res = YAML.load_file('res.yml')
    nb_docs = 0
    nb_success = 0

    puts "==========================================="
    
    res.each do |key, content|
        exception = false
        nb_docs += content["paths"].length()
        content["url"] = CGI.unescape(content["url"]) # Decodes url symbols into literal characters
        puts "Loading documentation from #{key}".yellow
    
        # gets exact repo name from url
        repoName = (content["url"].split("/")[-1]).gsub(".git", "")
        # gets exact repo path (ex: cqen-qdce/plateforme-accueil-centre-innovation)
        repoPath = content["url"].split("github.com/")[1].gsub(".git", "")
        # gets repo owner (ex: CQEN-QDCE)
        owner = repoPath.split('/')[0]

        # Deletes current site folder if it existed
        system("rm -rf ../_documentation-labs/#{repoName}")
        system("mkdir ../_documentation-labs/#{repoName}")

        # Get repo description and last push to default branch
        command = 'curl -s -H "Authorization: Bearer ' + secret + '" \
                -H  "Content-Type:application/json" \
                -d \'{ 
                     "query": "{ repository(owner: \"' + owner + '\", name: \"' + repoName + '\") '+
                     ' { description, pushedAt } }"}\' https://api.github.com/graphql '
        json = JSON.parse(`#{command}`)
        description = json["data"]["repository"]["description"]
        repoDate = json["data"]["repository"]["pushedAt"]

        # Runs through each files to be included and moves/renames them to a new folder
        for path in content["paths"] do
            begin
                path = CGI.unescape(path) # Decodes url symbols into utf characters
                puts("-- #{path}".yellow)
                url = path
                fileName = path.split("/")[-1]
                filePath = path.split("blob/")[-1]
                branch = filePath.split("/")[0]
                filePath = filePath.gsub(branch + "/", "")

                # gets the date with the graphql github api
                command = 'curl -s -H "Authorization: Bearer ' + secret + '" \
                -H  "Content-Type:application/json" \
                -d \'{ 
                     "query": "{ repository(owner: \"' + owner + '\", name: \"' + repoName + '\") '+
                     '{ ref(qualifiedName: \"refs/heads/' + branch + '\") ' +
                     '{ target { ... on Commit { history(first: 1, path: \"' + filePath + '\") ' + 
                     '{ edges { node { committedDate } } } } } } } }"}\' https://api.github.com/graphql '
                json = JSON.parse(`#{command}`)
                if (!$?.success?)
                    raise "Impossible to get date from github api, check if project's url for " +
                    "#{key} is valid. If it is, you may be getting rate limited by github api.\n"
                else
                    dateIso = json["data"]["repository"]["ref"]["target"]["history"]["edges"][0]["node"]["committedDate"] # I am so sorry
                    dateShort = dateIso[0..9]  #Gets the date of the last commit on this file YYYY-MM-DD format
                end

                raw = path.gsub("github.com", "raw.githubusercontent.com").gsub("/blob/", "/") # Gets raw file from normal url
                system("wget \"#{raw}\"")
                if (!$?.success?)
                    raise "Impossible to wget file from #{path}, check if path provided is valid.\n"
                end
                file_prepend(fileName, dateIso, repoName, path)
                system("mv #{fileName} ../_documentation-labs/#{repoName}/#{dateShort}-#{fileName}")
                create_index("../_documentation-labs/#{repoName}", "#{repoName}", content["project-title"], 
                    content["url"], description, repoDate)
                nb_success += 1
            rescue => e
                puts(">>> An error occured while processing file".light_red)
                if trace
                    puts(">>> Full exception: #{e.full_message}".light_black)
                else
                    puts(">>> ERROR: #{e.message}".light_red)
                    puts(">>> Call this script with the --trace option if you want to see the full error".light_black)
                end
                exception = true
                error = true
            end
        end
        if !exception
            puts "#{repoName}\'s documentation loaded successfully!".green
        else
            puts "Some or all documents have not been successfully loaded, check console output".magenta
        end
        puts "==========================================="
    end 
    if nb_docs != nb_success
        puts "#{nb_success}/#{nb_docs} files passed! Check console output to fix errors.".red
    else
        puts "#{nb_success}/#{nb_docs} files passed! The documentation has been successfully loaded.".green
    end
end

main