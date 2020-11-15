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
    $stdout.puts "Initializing " + browser + " browser"
  end

  def get_driver
    @driver
  end

  def navigate_to_url(url)
    $stdout.puts "Maximize browser"
    @driver.manage.window.maximize
    $stdout.puts "Deleting all cookies"
    @driver.manage.delete_all_cookies
    $stdout.puts "Navigating to " + url
    @driver.navigate.to url
    check_captcha
  end

  def find_element(locator, value)
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { @driver.find_element(locator, value) }
    # @driver.find_element(locator, value)
  end

  def find_elements(locator, value)
    wait = Selenium::WebDriver::Wait.new(:timeout => get_timeout.to_i)
    wait.until { @driver.find_elements(locator, value) }
    # @driver.find_elements(locator, value)
  end

  def find_child_element(element, locator, value)
    wait = Selenium::WebDriver::Wait.new(:timeout => get_timeout.to_i)
    wait.until { element.find_element(locator, value) }
    # element.find_element(locator, value)
  end

  def find_child_elements(element, locator, value)
    wait = Selenium::WebDriver::Wait.new(:timeout => get_timeout.to_i)
    wait.until { element.find_elements(locator, value) }
    # element.find_elements(locator, value)
  end

  def wait_until_element_is_present(element)
    wait = Selenium::WebDriver::Wait.new(:timeout => get_timeout.to_i)
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

  def get_timeout
    get_property('timeout')
  end

  def check_captcha
    sleep(2)
    captcha = find_elements(:tag_name, 'h1').select { |el| el.text == 'Please verify you are a human'}.first
    if captcha.nil?
      return false
    end
    if captcha.displayed?
      $stdout.puts "Captcha is present and script will wait for 60 secs"
      sleep(60)
    end
  end

  def close_browser
    @driver.quit
  end

end