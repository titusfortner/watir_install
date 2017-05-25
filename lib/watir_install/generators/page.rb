require 'thor/group'
require 'git'
require 'active_support/inflector'

module WatirInstall
  module Generators
    class Page < Thor::Group
      include Thor::Actions

      argument :klass, type: :string, desc: 'The page object being created'
      argument :url, type: :string, default: '', desc: 'The Page URL'
      argument :form, type: :string, default: '', desc: 'Generates #submit_form'
      argument :elements, required: false, default: [], type: :array, desc: 'These are elements on page'

      def self.source_root
        "#{File.dirname(__FILE__)}/pages"
      end

      def git
        @git = Git.open('./') if Dir.entries('./').include?('.git')
      end

      def name
        Dir.pwd[/[^\/]*$/]
      end

      def page_files
        file = "#{Dir.pwd}/spec/support/pages/#{klass.downcase.gsub('::', '/')}.rb"
        template "spec/support/pages/page.rb.tt", file
        @git.add(file) if @git
      end

    end
  end
end