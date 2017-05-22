require 'thor/group'

module WatirInstall
  module Generators
    class Example < Thor::Group
      include Thor::Actions

      def self.source_root
        "#{File.dirname(__FILE__)}/example"
      end

      def name
        'google_search'
      end

      def lib_files
        template "lib/pages/home.rb.tt", "lib/#{name}/pages/home.rb"
        template "lib/pages/results.rb.tt", "lib/#{name}/pages/results.rb"
      end

      def data_files
        template "lib/data/search.rb.tt", "lib/#{name}/data/search.rb"
      end

      def test_files
        template "spec/search_spec.rb.tt", "spec/search_spec.rb"
      end
    end
  end
end