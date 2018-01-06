require 'sauce_whisk'

module SauceLabs
  def initialize_driver(name = nil)
    capabilities = Model::Capabilities.create(name: name)

    Watir::Browser.new capabilities.browser_name, capabilities.to_h
  end

  def submit_results(browser, result)
    SauceWhisk::Jobs.change_status(browser.wd.session_id, result)
  end
end
