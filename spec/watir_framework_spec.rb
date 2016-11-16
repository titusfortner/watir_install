require "spec_helper"

describe WatirFramework do
  it "starts a driver" do
    browser = Watir::Browser.new
    expect(browser.window).to exist
    browser.quit
  end

  it "submits a search" do
    search_data = WatirFramework::Model::Search.new
    WatirDrops::PageObject.browser = Watir::Browser.new
    search_page = WatirFramework::Home.visit
    search_page.search(search_data)
    expect(WatirFramework::Results.new.first_result).to eq search_data.first_result
    WatirDrops::PageObject.browser.quit
  end
end
