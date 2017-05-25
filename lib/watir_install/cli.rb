require 'thor'
require 'require_all'
require_rel 'generators'

module WatirInstall
  class CLI < Thor

    desc "new <project_name>", "Create a new test project"
    method_option :no_git, type: :boolean, desc: "Do not initialize project with git"
    method_option :base_url, type: :string, desc: "Set a root url for the project"

    def new(name)
      WatirInstall::Generators::New.start([name, options[:base_url], options[:no_git]])
    end

    desc "generate <generated_type>", "Generate a new object"
    method_option :url, type: :string, desc: "Do not initialize project with git"
    method_option :form, type: :string, desc: "Do not initialize project with git"

    def generate(generated_type, klass, *args)
      url = options[:url] || ''
      form = options[:form] || ''

      send("generate_#{generated_type}", klass, url, form, *args)
    end

    desc "generate_data <Class>", "Generate a new data object"

    def generate_data(klass, _url, _form, *args)
      WatirInstall::Generators::Data.start([klass, *args])
    end

    desc "generate_page <Class>", "Generate a new page object"

    def generate_page(klass, url, form, *args)
      form = klass[/[^:]*$/] if form == 'true'
      klass = klass[/^[^:]*/]
      WatirInstall::Generators::Page.start([klass, url, form, *args])
    end

    desc "generate_test <Class>", "Generate a new test"

    def generate_test(klass, _url, form, *args)
      WatirInstall::Generators::Test.start([klass, form, *args])
    end

    desc "generate_scaffold <Class>", "Generate collection of data, pages and tests"

    def generate_scaffold(klass, url, _form, *args)
      WatirInstall::Generators::Test.start([klass, 'true'])

      WatirInstall::Generators::Data.start([klass, *args])

      new_url = url.nil? ? '' : "#{url}/new"

      WatirInstall::Generators::Page.start(["#{klass}::List", url, ''])
      WatirInstall::Generators::Page.start(["#{klass}::New", new_url, klass, *args])
      # TODO: generate dynamic url method for Show & Edit
      WatirInstall::Generators::Page.start(["#{klass}::Show", '', '', *args])
      WatirInstall::Generators::Page.start(["#{klass}::Edit", '', klass, *args])
    end

    desc "example", "Create a new test project"
    method_option :no_git, type: :boolean, desc: "Do not initialize project with git"

    def example
      WatirInstall::Generators::New.start(['google_search', options[:no_git]])
      WatirInstall::Generators::Example.start
    end

  end
end
