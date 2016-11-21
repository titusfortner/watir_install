require 'thor/group'
require 'git'
require 'active_support/inflector'

class NewProject < Thor::Group
  include Thor::Actions

  argument :name, banner: 'creates new test project'

  def self.source_root
    File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
  end

  def git
    @git ||= Git.init(name)
  end

  def user_name
    @user_name ||= git.config["user.name"]
    return @user_name if @user_name
    @user_name = ask "Enter your Name:  "
    @git.config('user.name', @user_name)
    @user_name
  end

  def user_email
    @user_email ||= git.config["user.email"]
    return @user_email if @user_email
    @user_email = ask "Enter your Email: "
    @git.config('user.email', @user_email)
    @user_email
  end

  def root_files
    template "gemfile.rb.erb", "#{name}/Gemfile"
    template "gemspec.rb.erb", "#{name}/#{name}.gemspec"
    template "gitignore.rb.erb", "#{name}/.gitignore"
    template "license.rb.erb", "#{name}/LICENSE.txt"
    template "rakefile.rb.erb", "#{name}/Rakefile"
    template "readme.rb.erb", "#{name}/README.md"
    template "rspec.rb.erb", "#{name}/.rspec"
    template "travis.rb.erb", "#{name}/.travis.yml"
  end

  def lib_files
    template "lib/name.rb.erb", File.join(name, "lib", "#{name}.rb")
    template "lib/pages/home.rb.erb", File.join(name, "lib", name, "pages", "home.rb")
    template "lib/pages/results.rb.erb", File.join(name, "lib", name, "pages", "results.rb")
    template "lib/models/search.rb.erb", File.join(name, "lib", name, "models", "search.rb")
  end

  def spec_files
    template "spec/name_spec.rb.erb", File.join(name, "spec", "#{name}_spec.rb")
    template "spec/spec_helper.rb.erb", File.join(name, "spec", "spec_helper.rb")
  end

  def initial_commit
    git.lib.add('.', all: true)
    git.commit("initial commit", {all: true})
  end
end
