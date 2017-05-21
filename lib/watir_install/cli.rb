require 'thor'
require 'watir_install/generators/new'

module WatirInstall
  class CLI < Thor

    desc "new <project_name>", "Create a new test project"
    method_option :no_git, type: :boolean, desc: "Do not initialize project with git"
    method_option :test_runner, type: :string, desc: "Do not initialize project with git"


    def new(name)
      no_git = options[:no_git] ? 'true' : 'false'
      test_runner = options[:test_runner]
      WatirInstall::Generators::New.start([name, no_git, test_runner])
    end
    
  end
end
