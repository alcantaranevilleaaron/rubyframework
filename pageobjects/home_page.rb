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
    $stdout.puts "Enter " + keyword + " in Find professional & Agencies"
    find_textbox.send_keys(keyword)
    $stdout.puts "Click magnifying glass button "
    search_button.click

    # # Workaround to check for captcha and wait after clicking submit
    @driver.check_captcha
    # sleep(5)
    # if @driver.check_captcha
    #   $stdout.puts "Captcha is present and script will wait for 60 secs"
    #   sleep(60)
    # end

    SearchResultPage.new(@driver)
  end

end
