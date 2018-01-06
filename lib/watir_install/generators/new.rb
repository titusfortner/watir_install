require 'thor/group'
require 'git'
require 'active_support/inflector'

module WatirInstall
  module Generators
    class New < Thor::Group
      include Thor::Actions

      argument :name, type: :string, desc: 'The name of the test project'
      argument :base_url, required: false, desc: 'Set a root url for the project'
      argument :no_git, required: false, desc: 'Do not initialize project with git'

      def self.source_root
        "#{File.dirname(__FILE__)}/new"
      end

      def git?
        return @git unless @git.nil?
        return false unless no_git
        response = ask "Do you want to initialize with git? (Y/N)"
        @git = response[0].downcase == 'y'
      end

      def user_name
        if git?
          @git = Git.init(name)
          @user_name ||= @git.config["user.name"]
          @user_name ||= ask "Enter your Name:  "
          @git.config('user.name', @user_name)
          @user_name
        end
      end

      def user_email
        if git?
          @user_email ||= @git.config["user.email"]
          @user_email ||= ask "Enter your Email: "
          @git.config('user.email', @user_email)
          @user_email
        end
      end

      def root_files
        template "gemfile.rb.tt", "#{name}/Gemfile"
        template "gitignore.rb.tt", "#{name}/.gitignore"
        template "rakefile.rb.tt", "#{name}/Rakefile"
        template "readme.rb.tt", "#{name}/README.md"
        template "rspec.rb.tt", "#{name}/.rspec"
        template "travis.rb.tt", "#{name}/.travis.yml"
      end

      def test_files
        template "spec/spec_helper.rb.tt", "#{name}/spec/spec_helper.rb"
        template "spec/name_spec.rb.tt", "#{name}/spec/#{name}_spec.rb"
      end

      def api_files
        template "spec/support/apis.rb.tt", "#{name}/spec/support/apis.rb"
        template "common/empty.rb.tt", "#{name}/spec/support/apis/.keep"
      end

      def config_files
        template "common/empty.rb.tt", "#{name}/spec/support/config/data/config.yml"
      end

      def data_files
        template "spec/support/data.rb.tt", "#{name}/spec/support/data.rb"
        template "spec/support/data/config.rb.tt", "#{name}/spec/support/data/config.rb"
      end

      def helper_files
        template "spec/support/helpers/sauce_labs.rb.tt", "#{name}/spec/support/helpers/sauce_labs.rb"
      end

      def page_files
        template "spec/support/pages.rb.tt", "#{name}/spec/support/pages.rb"
        template "common/empty.rb.tt", "#{name}/spec/support/pages/.keep"
      end

      def site_files
        template "spec/support/sites.rb.tt", "#{name}/spec/support/sites.rb"
        template "spec/support/sites/name.rb.tt", "#{name}/spec/support/sites/#{name}.rb"
      end

      def bundle
        Dir.chdir(name)
        system 'bundle install'
      end

      def initial_commit
        if git?
          @git.lib.add('.', all: true)
          @git.commit("initial commit by Watir Install. http://github.com/titusfortner/watir_install", {all: true})
        end
      end
    end
  end
end