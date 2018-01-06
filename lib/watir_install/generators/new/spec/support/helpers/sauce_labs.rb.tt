require 'sauce_whisk'

module SauceLabs
  def initialize_driver(name = nil)
    @name = name || "Unknown Test at #{Time.now.to_i}"
    capabilities = {name: @name,
                    build: ENV['BUILD_TAG'] ||= "Unknown Build at #{Time.now.to_i}"}
    capabilities[:browserName] = ENV['browserName'] || :chrome

    capabilities[:platform] = ENV['platform'] if ENV['platform']
    capabilities[:version] = ENV['version'] if ENV['version']

    url = "https://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:443/wd/hub".strip
    @browser = Watir::Browser.new :remote, {url: url,
                                            desired_capabilities: capabilities}
  end

  def submit_results(browser, result)
    SauceWhisk::Jobs.change_status(browser.wd.session_id, result)
  end
end
