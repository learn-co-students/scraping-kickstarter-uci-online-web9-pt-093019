# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  project_hash = {}
  kickstarter = Nokogiri::HTML(File.read('fixtures/kickstarter.html'))
  projects = kickstarter.css("li.project.grid_4")

  projects.each do |project|
    name = project.css("h2.bbcard_name strong a").text
    image = project.css(".project-thumbnail a img").attribute("src").value
    description = project.css("p.bbcard_blurb").text.strip
    location = project.css("ul.project-meta").text.strip
    funded = project.css("ul.project-stats li.first.funded strong").text.gsub("%", " ").to_i

    project_hash[name] = {:image_link => image,
                          :description => description,
                          :location => location,
                          :percent_funded => funded}
  end
  project_hash
end
