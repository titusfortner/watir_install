require "spec_helper"

describe WatirFramework do
  it "starts a driver" do
    browser = Watir::Browser.new
    expect(browser.window).to exist
  end
end
