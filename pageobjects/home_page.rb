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

  # This will search a keyword in the Find professional & agencies textbox and click magnifying glass to submit
  # String keyword
  # Return SearchResultPage instance
  def search_professional(keyword)
    $stdout.puts "Enter " + keyword + " in Find professional & Agencies"
    find_textbox.send_keys(keyword)
    $stdout.puts "Click magnifying glass button "
    search_button.click
    @driver.check_captcha
    SearchResultPage.new(@driver)
  end

end
