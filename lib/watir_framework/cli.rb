require 'thor'
require 'watir_framework/generators/new_project'

module WatirFramework
  class CLI < Thor

    desc "new <project_name>", "Create a new test project"


    def new(name)
      WatirFramework::Generators::NewProject.start([name])
    end
    
  end
end
