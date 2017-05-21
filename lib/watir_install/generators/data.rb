require 'thor/group'
require 'git'
require 'active_support/inflector'

module WatirInstall
  module Generators
    class Data < Thor::Group
      include Thor::Actions

      argument :klass, type: :string, desc: 'The data object being created'
      argument :keys, type: :array, desc: 'These are keys for data'

      def self.source_root
        "#{File.dirname(__FILE__)}/data"
      end

      def name
        File.expand_path(File.dirname(__FILE__))[/([^\/]*)\/[^\/]*$/, 1]
      end

      def data_files
        template "lib/models/data.rb.tt", "lib/#{name}/data/#{klass.downcase}.rb"
      end

    end
  end
end