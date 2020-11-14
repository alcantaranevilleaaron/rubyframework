require 'selenium-webdriver'

class Driver

  def initialize
    Selenium::WebDriver::Chrome::Service.driver_path = File.expand_path('..') + "/resources/drivers/chromedriver.exe"
    @driver = Selenium::WebDriver.for :chrome
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

  def contains_ignore_case(str, keyword)
    (str =~ /#{keyword}/i) != nil
  end

  def close_browser
    @driver.quit
  end

end