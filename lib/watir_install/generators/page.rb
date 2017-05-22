require 'thor/group'
require 'git'
require 'active_support/inflector'

module WatirInstall
  module Generators
    class Page < Thor::Group
      include Thor::Actions

      argument :klass, type: :string, desc: 'The page object being created'
      argument :url, type: :string, default: '', desc: 'The Page URL'
      argument :form, type: :string, default: 'false', desc: 'Generates #submit_form'
      argument :elements, required: false, default: [], type: :array, desc: 'These are elements on page'

      def self.source_root
        "#{File.dirname(__FILE__)}/pages"
      end

      def name
        File.expand_path(File.dirname(__FILE__))[/([^\/]*)\/[^\/]*$/, 1]
      end

      def data_files
        template "lib/pages/page.rb.tt", "lib/#{name}/pages/#{klass.downcase.gsub('::', '/')}.rb"
      end

    end
  end
end