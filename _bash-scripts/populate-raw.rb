# This script loads all the files specified by the "path" keyword in res.yaml by cloning
# the whole project from url then moving and renaming them on the site
require 'yaml'
require_relative 'utils'

# Main script
def main
    res = YAML.load_file('res-raw.yml')

    res.each do |key, content|
        puts "==========================================="
        puts "Loading documentation from #{content["url"]}"
    
        # gets exact repo name from url
        repoName = (content["url"].split("/")[-1]).gsub(".git", "")
        # gets exact repo path (ex: cqen-qdce/plateforme-accueil-centre-innovation)
        repoPath = content["url"].split("github.com/")[1].gsub(".git", "")

        # Deletes current site folder if it existed
        system("rm -rf ../_documentation-labs/#{repoName}")
        system("mkdir ../_documentation-labs/#{repoName}")
        url = ""
    
        begin
        # Runs through each files to be included and moves/renames them to a new folder
            for path in content["paths"] do
                url = path
                fileName = path.split("/")[-1]
                filePath = path.split("blob/")[-1]
                branch = filePath.split("/")[0]
                filePath = filePath.gsub(branch + "/", "")
                command = "curl -s \"https://api.github.com/repos/#{repoPath}/commits?path=#{filePath}&page=1&per_page=1\" | \
                jq -r '.[0].commit.committer.date'"
                dateIso = `#{command}` # Gets the date of the last commit on this file Iso format
                dateShort = dateIso[0..9]  #Gets the date of the last commit on this file YYYY-MM-DD format

                raw = path.gsub("github.com", "raw.githubusercontent.com").gsub("/blob/", "/") # Gets raw file from normal url
                system("wget \"#{raw}\"")
                file_prepend("#{fileName}", dateIso, "#{repoName}")
                system("mv #{fileName} ../_documentation-labs/#{repoName}/#{dateShort}-#{fileName}")
                create_index("../_documentation-labs/#{repoName}", "#{repoName}", "#{content["project-title"]}")
            end

        rescue => exception
            puts("An error occured while trying to get file from url: #{url}")
            puts(exception.full_message)
        end
        
        puts "#{repoName}\'s documentation loaded successfully!"
    end 
end

main