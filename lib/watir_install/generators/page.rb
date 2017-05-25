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

      def name
        Dir.pwd[/[^\/]*$/]
      end

      def data_files
        template "spec/support/pages/page.rb.tt", "#{Dir.pwd}/spec/support/pages/#{klass.downcase.gsub(':', '/')}.rb"
      end

    end
  end
end