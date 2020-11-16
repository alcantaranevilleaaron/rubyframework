require 'selenium-webdriver'
require 'yaml'

# Driver class which will holds most driver utility methods
class Driver

  # Initialize driver
  # Browser is set under /resources/config/config.yml configuration file (Valid values are 'chrome' and 'firefox' for now)
  # Return driver instance
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

  # Getter for driver
  def get_driver
    @driver
  end

  # This will navigate user to a given url
  # String url
  def navigate_to_url(url)
    $stdout.puts "Maximize browser"
    @driver.manage.window.maximize
    $stdout.puts "Deleting all cookies"
    @driver.manage.delete_all_cookies
    $stdout.puts "Navigating to " + url
    @driver.navigate.to url
    check_captcha
  end

  # This will get element based on the locator and value provided
  # String locator, value
  # Return webelement instance
  def find_element(locator, value)
    wait = Selenium::WebDriver::Wait.new(:timeout => get_timeout)
    wait.until { @driver.find_element(locator, value) }
  end

  # This will get elements based on the locator and value provided
  # String locator, value
  # Return group of webelement instance
  def find_elements(locator, value)
    wait = Selenium::WebDriver::Wait.new(:timeout => get_timeout)
    wait.until { @driver.find_elements(locator, value) }
  end

  # This will get child element based on the parent element, locator and value provided
  # Webelement webelement;  String locator, value
  # Return webelement instance
  def find_child_element(element, locator, value)
    wait = Selenium::WebDriver::Wait.new(:timeout => get_timeout)
    wait.until { element.find_element(locator, value) }
  end

  # This will get child elements based on the parent element, locator and value provided
  # Webelement webelement; String locator, value
  # Return group of webelement instance
  def find_child_elements(element, locator, value)
    wait = Selenium::WebDriver::Wait.new(:timeout => get_timeout)
    wait.until { element.find_elements(locator, value) }
  end

  # This will wait for an element to be displayed
  # Webelement element
  # Return boolean if element is displayed
  def wait_until_element_is_present(element)
    wait = Selenium::WebDriver::Wait.new(:timeout => get_timeout)
    wait.until { element.displayed? }
  end

  # This will check whether a substring in present in a string
  # String string, substring
  # Return boolean if substring is present in a string
  def contains_ignore_case(string, substring)
    (string =~ /#{substring}/i) != nil
  end

  # Extract value of a property inside the config file
  # String prop_name
  # Return String value based on the property provided (Current properties are browser, url, timeout)
  def get_property(prop_name)
    config_path = File.expand_path('..') + "/resources/config/config.yml"
    config = YAML.load_file(config_path)
    config[prop_name]
  end

  # Extract browser value inside the config file
  # Return String value provided for browser
  def get_browser
    get_property('browser')
  end

  # Extract timeout value inside the config file
  # Return Integer value provided for browser
  def get_timeout
    get_property('timeout').to_i
  end

  # Extract captcha wait value inside the config file
  # Return Integer value provided for browser
  def get_captcha_wait
    get_property('captcha_wait').to_i
  end

  # Workaround to check for captcha
  def check_captcha
    sleep(2)
    captcha = find_elements(:tag_name, 'h1').select { |el| el.text == 'Please verify you are a human'}.first
    if captcha.nil?
      return false
    end
    if captcha.displayed?
      captcha_wait = get_captcha_wait
      $stdout.puts "Captcha is present and script will wait for " + captcha_wait.to_s + " secs"
      sleep(captcha_wait)
    end
  end

  # Close the browser instance
  def close_browser
    @driver.quit
  end

end