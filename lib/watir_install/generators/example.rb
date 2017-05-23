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

      def support_files
        template "spec/support/pages/home.rb.tt", "spec/support/pages/home.rb"
        template "spec/support/pages/results.rb.tt", "spec/support/pages/results.rb"
      end

      def data_files
        template "spec/support/data/search.rb.tt", "spec/support/data/search.rb"
      end

      def test_files
        template "spec/search_spec.rb.tt", "spec/search_spec.rb"
      end
    end
  end
end