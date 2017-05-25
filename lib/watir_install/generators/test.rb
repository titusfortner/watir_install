require 'thor/group'
require 'git'
require 'active_support/inflector'

module WatirInstall
  module Generators
    class Test < Thor::Group
      include Thor::Actions

      argument :klass, type: :string, desc: 'The data object being created'
      argument :form, type: :string, default: '', desc: 'Generates #submit_form'
      argument :specs, required: false, default: [], type: :array, desc: 'Specs for'

      def self.source_root
        "#{File.dirname(__FILE__)}/tests"
      end

      def git
        @git = Git.open('./') if Dir.entries('./').include?('.git')
      end

      def name
        Dir.pwd[/[^\/]*$/]
      end

      def data_files
        file = "#{Dir.pwd}/spec/#{klass.downcase}_spec.rb"
        erb = form == 'true' ? "crud" : "spec"
        template "spec/#{erb}.rb.tt", file
        @git.add(file) if @git
      end

    end
  end
end