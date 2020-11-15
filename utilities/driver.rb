require 'selenium-webdriver'
require 'yaml'

class Driver

  def initialize
    browser = get_browser
    if browser.eql?('firefox')
      Selenium::WebDriver::Chrome::Service.driver_path = File.expand_path('..') + "/resources/drivers/geckodriver.exe"
      @driver = Selenium::WebDriver.for :firefox
    else
      Selenium::WebDriver::Chrome::Service.driver_path = File.expand_path('..') + "/resources/drivers/chromedriver.exe"
      @driver = Selenium::WebDriver.for :chrome
    end
  end

  def get_driver
    @driver
  end

  def navigate_to_url(url)
    @driver.manage.window.maximize
    @driver.manage.delete_all_cookies
    @driver.navigate.to url
  end

  def find_element(locator, value)
    @driver.find_element(locator, value)
  end

  def find_elements(locator, value)
    @driver.find_elements(locator, value)
  end

  def find_child_element(element, locator, value)
    element.find_element(locator, value)
  end

  def find_child_elements(element, locator, value)
    element.find_elements(locator, value)
  end

  def wait_until_element_is_present(element)
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { element.displayed? }
  end

  def contains_ignore_case(str, keyword)
    (str =~ /#{keyword}/i) != nil
  end

  def get_property(prop_name)
    config_path = File.expand_path('..') + "/resources/config/config.yml"
    config = YAML.load_file(config_path)
    config[prop_name]
  end

  def get_browser
    get_property('browser')
  end

  def close_browser
    @driver.quit
  end

end