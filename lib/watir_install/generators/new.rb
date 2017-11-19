require 'thor/group'
require 'git'
require 'active_support/inflector'

module WatirInstall
  module Generators
    class New < Thor::Group
      include Thor::Actions

      argument :name, type: :string, desc: 'The name of the test project'
      argument :base_url, type: :string, required: false, default: '', desc: 'Set a root url for the project'
      argument :no_git, type: :string, required: false, default: 'false', desc: 'Do not initialize project with git'

      def self.source_root
        "#{File.dirname(__FILE__)}/new"
      end

      def user_name
        if no_git == 'false'
          @git = Git.init(name)
          @user_name ||= @git.config["user.name"]
          @user_name ||= ask "Enter your Name:  "
          @git.config('user.name', @user_name)
          @user_name
        end
      end

      def user_email
        if no_git == 'false'
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
        template "travis.rb.tt", "#{name}/.travis.yml"
        template "rspec.rb.tt", "#{name}/.rspec"
      end

      def test_files
        template "spec/spec_helper.rb.tt", "#{name}/spec/spec_helper.rb"
      end

      def data_files
        template "spec/support/data/base.rb.tt", "#{name}/spec/support/data/base.rb"
      end

      def page_files
        template "spec/support/pages/base.rb.tt", "#{name}/spec/support/pages/base.rb"
      end

      def support_files
        template "spec/support/sauce_helpers.rb.tt", "#{name}/spec/support/sauce_helpers.rb"
        template "spec/support/site.rb.tt", "#{name}/spec/support/site.rb"
      end

      def bundle
        Dir.chdir(name)
        system 'bundle install'
      end

      def initial_commit
        if no_git == 'false'
          @git.lib.add('.', all: true)
          @git.commit("initial commit", {all: true})
        end
      end
    end
  end
end