require "spec_helper"

describe WatirFramework do
  it "has a version number" do
    expect(WatirFramework::VERSION).not_to be nil
  end

  it "starts a driver" do
    browser = Watir::Browser.new
    expect(browser.window).to exist
  end
end
