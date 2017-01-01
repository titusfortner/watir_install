require 'thor'
require 'watir_install/generators/new_project'

module WatirInstall
  class CLI < Thor

    desc "new <project_name>", "Create a new test project"


    def new(name)
      WatirInstall::Generators::NewProject.start([name])
    end
    
  end
end
