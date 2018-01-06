require 'spec_helper'

RSpec.describe WatirInstall do
  it "runs stuff" do
    WatirInstall::Generators::New.start(['foobar', 'http://watir.com', false])
    puts 'yay stuff ran'
  end
end
