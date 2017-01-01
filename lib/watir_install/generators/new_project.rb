require 'thor/group'
require 'git'
require 'active_support/inflector'

module WatirInstall
  module Generators
    class NewProject < Thor::Group
      include Thor::Actions

      argument :name, type: :string, desc: 'The name of the test project'
      argument :no_git, type: :string, desc: 'Do not initialize project with git'

      def self.source_root
        "#{File.dirname(__FILE__)}/new_project"
      end

      def git
        @git ||= Git.init(name)
      end

      def user_name
        @user_name ||= git.config["user.name"] if git?
        @user_name ||= ask "Enter your Name:  "
        @git.config('user.name', @user_name) if git?
        @user_name
      end

      def user_email
        @user_email ||= git.config["user.email"] if git?
        @user_email ||= ask "Enter your Email: "
        @git.config('user.email', @user_email) if git?
        @user_email
      end

      def root_files
        template "gemfile.rb.tt", "#{name}/Gemfile"
        template "gitignore.rb.tt", "#{name}/.gitignore"
        template "license.rb.tt", "#{name}/LICENSE.txt"
        template "rakefile.rb.tt", "#{name}/Rakefile"
        template "readme.rb.tt", "#{name}/README.md"
        template "rspec.rb.tt", "#{name}/.rspec"
        template "ruby-version.rb.tt", "#{name}/.ruby-version"
        template "travis.rb.tt", "#{name}/.travis.yml"
      end

      def lib_files
        template "lib/name.rb.tt", File.join(name, "lib", "#{name}.rb")
        template "lib/pages/home.rb.tt", File.join(name, "lib", name, "pages", "home.rb")
        template "lib/pages/results.rb.tt", File.join(name, "lib", name, "pages", "results.rb")
        template "lib/models/search.rb.tt", File.join(name, "lib", name, "models", "search.rb")
      end

      def spec_files
        template "spec/name_spec.rb.tt", File.join(name, "spec", "#{name}_spec.rb")
        template "spec/spec_helper.rb.tt", File.join(name, "spec", "spec_helper.rb")
      end

      def initial_commit
        if git?
          git.lib.add('.', all: true)
          git.commit("initial commit", {all: true})
        end
      end

      def git?
        no_git != 'true'
      end
    end
  end
end