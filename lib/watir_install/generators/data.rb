require 'thor/group'
require 'git'
require 'active_support/inflector'
require 'data_magic/standard_translation'

module WatirInstall
  module Generators
    class Data < Thor::Group
      include Thor::Actions

      TRANSLATIONS = %i(full_name first_name last_name name_prefix name_suffix
      title street_address secondary_address city state state_abbr zip_code
      country company_name catch_phrase credit_card_number credit_card_type
      words sentence sentences paragraphs characters email_address domain_name
      url user_name phone_number cell_phone password).freeze

      argument :klass, type: :string, desc: 'The data object being created'
      argument :keys, required: false, default: [], type: :array, desc: 'These are keys for data'

      def self.source_root
        "#{File.dirname(__FILE__)}/data"
      end

      def name
        Dir.pwd[/[^\/]*$/]
      end

      def data_files
        template "spec/support/data/data.rb.tt", "#{Dir.pwd}/spec/support/data/#{klass.downcase}.rb"
      end

    end
  end
end