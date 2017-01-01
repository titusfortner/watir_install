require 'thor'
require 'watir_install/generators/new_project'

module WatirInstall
  class CLI < Thor

    desc "new <project_name>", "Create a new test project"
    method_option :no_git, type: :boolean, desc: "Do not initialize project with git"


    def new(name)
      no_git = options[:no_git] ? 'true' : 'false'
      WatirInstall::Generators::NewProject.start([name, no_git])
    end
    
  end
end
