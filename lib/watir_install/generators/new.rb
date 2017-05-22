require 'thor/group'
require 'git'
require 'active_support/inflector'

module WatirInstall
  module Generators
    class New < Thor::Group
      include Thor::Actions

      argument :name, type: :string, desc: 'The name of the test project'
      argument :no_git, type: :string, default: 'false', desc: 'Do not initialize project with git'

      def self.source_root
        "#{File.dirname(__FILE__)}/new"
      end

      def user_name
        unless no_git
          @git = Git.init(name)
          @user_name ||= @git.config["user.name"]
          @user_name ||= ask "Enter your Name:  "
          @git.config('user.name', @user_name)
          @user_name
        end
      end

      def user_email
        unless no_git
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
        template "ruby-version.rb.tt", "#{name}/.ruby-version"
        template "travis.rb.tt", "#{name}/.travis.yml"
        template "rspec.rb.tt", "#{name}/.rspec"
      end

      def lib_files
        template "lib/name.rb.tt", "#{name}/lib/#{name}.rb"
        template "lib/pages/base.rb.tt", "#{name}/lib/#{name}/pages/base.rb"
      end

      def data_files
        template "lib/data/base.rb.tt", "#{name}/lib/#{name}/data/base.rb"
      end

      def test_files
        template "spec/spec_helper.rb.tt", "#{name}/spec/spec_helper.rb"
      end

      def bundle
        Dir.chdir(name)
        system 'bundle install'
      end

      def initial_commit
        unless no_git
          @git.lib.add('.', all: true)
          @git.commit("initial commit", {all: true})
        end
      end
    end
  end
end