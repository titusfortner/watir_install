require "spec_helper"

describe WatirFramework do
  it "starts a driver" do
    browser = Watir::Browser.new
    expect(browser.window).to exist
    browser.quit
  end

  it "submits a search" do
    WatirDrops::PageObject.browser = Watir::Browser.new
    search_page = WatirFramework::Home.visit
    search_page.search('Foo')
    expect(WatirFramework::Results.new.first_result).to eq "Foobar - Wikipedia"
    WatirDrops::PageObject.browser.quit
  end
end
