require 'thor/group'
require 'git'
require 'active_support/inflector'

module WatirInstall
  module Generators
    class NewProject < Thor::Group
      include Thor::Actions

      argument :name, type: :string, desc: 'The name of the test project'
      argument :no_git, type: :string, default: 'false', desc: 'Do not initialize project with git'
      argument :test_runner, type: :string, default: 'rspec', desc: 'Specify RSpec or Cucumber'

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
        template "ruby-version.rb.tt", "#{name}/.ruby-version"
        template "travis.rb.tt", "#{name}/.travis.yml"
        if test_runner == 'cucumber'
          template "cucumber.yml.tt", "#{name}/.cucumber.yml"
        else
          template "rspec.rb.tt", "#{name}/.rspec"
        end
      end

      def lib_files
        if test_runner == 'cucumber'
          template "features/support/pages/home.rb.tt", "#{name}/features/support/pages/home.rb.rb"
          template "features/support/pages/results.rb.tt", "#{name}/features/support/pages/results.rb"
        else
          template "lib/name.rb.tt", "#{name}/lib/#{name}.rb"
          template "lib/pages/home.rb.tt", "#{name}/lib/#{name}/pages/home.rb"
          template "lib/pages/results.rb.tt", "#{name}/lib/#{name}/pages/results.rb"
        end
      end

      def data_files
        if test_runner == 'cucumber'
          template "config/data/data.yml.tt", "#{name}/config/data/data.yml"
        else
          template "lib/models/search.rb.tt", "#{name}/lib/#{name}/models/search.rb"
        end
      end

      def test_files
        if test_runner == 'cucumber'
          template "features/support/env.rb.tt", "#{name}/features/support/env.rb"
          template "features/support/hooks.rb.tt", "#{name}/features/support/hooks.rb"
          template "features/step_definitions/search_steps.rb.tt", "#{name}/features/step_definitions/search_steps.rb"
          template "features/search.feature.tt", "#{name}/features/search.feature"

        else
          template "spec/search_spec.rb.tt", "#{name}/spec/search_spec.rb"
          template "spec/spec_helper.rb.tt", "#{name}/spec/spec_helper.rb"
        end
      end

      def bundle
        Dir.chdir(name)
        system 'bundle install'
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