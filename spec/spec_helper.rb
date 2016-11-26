$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "watir_framework"
require "watir_session"

WatirSession.start

include WatirFramework

RSpec.configure do |config|
  config.before(:each) do
    WatirSession.before_each
    WatirDrops::PageObject.browser = WatirSession.browser
  end

  config.after(:each) do
    WatirSession.after_each
  end
end
