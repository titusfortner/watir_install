require 'thor'
require 'require_all'
require_rel 'generators'

module WatirInstall
  class CLI < Thor

    desc "new <project_name>", "Create a new test project"
    method_option :no_git, type: :boolean, desc: "Do not initialize project with git"
    method_option :test_runner, type: :string, desc: "Do not initialize project with git"
    def new(name)
      WatirInstall::Generators::New.start([name, options[:no_git], options[:test_runner]])
    end

    desc "generate <generated_type>", "Create a new data object"
    def generate(generated_type, klass, *args)
      send("generate_#{generated_type}", klass, *args)
    end

    desc "generate_data <Class>", "Create a new data object"
    def generate_data(klass, *args)
      WatirInstall::Generators::Data.start([klass, *args])
    end

    desc "generate_page <Class>", "Create a new page object"
    def generate_page(klass, *args)
      WatirInstall::Generators::Page.start([klass, *args])
    end

  end
end
