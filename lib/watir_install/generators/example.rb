require 'thor/group'

module WatirInstall
  module Generators
    class Example < Thor::Group
      include Thor::Actions

      def self.source_root
        "#{File.dirname(__FILE__)}/example"
      end

      def name
        'address_book'
      end

      def support_files
        template "spec/support/pages/login.rb.tt", "spec/support/pages/login.rb"
        template "spec/support/pages/session.rb.tt", "spec/support/pages/session.rb"
      end

      def data_files
        template "spec/support/data/search.rb.tt", "spec/support/data/invald_user.rb"
      end

      def test_files
        template "spec/login_spec.rb.tt", "spec/login_spec.rb"
      end
    end
  end
end