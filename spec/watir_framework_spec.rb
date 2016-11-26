require "spec_helper"

describe WatirFramework do
  let(:browser) { WatirSession.browser }

  it "starts a driver" do
    expect(browser.window).to exist
  end

  it "submits a search" do
    search_data = Model::Search.new
    search_page = Home.visit
    search_page.search(search_data)

    expect(Results.new.first_result).to eq search_data.first_result
  end
end
