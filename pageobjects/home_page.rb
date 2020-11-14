require_relative '../utilities/driver'
require_relative '../pageobjects/search_result_page'

class HomePage

  def initialize(driver)
    @driver = driver
  end

  def find_textbox
    @driver.find_element(:name, "q")
  end

  def search_button
    @driver.find_element(:css, "[icon-name='search']")
  end

  def search_professional(keyword)
    find_textbox.send_keys(keyword)
    search_button.click
    SearchResultPage.new(@driver)
  end

end
