require_relative '../pageobjects/home_page.rb'

#define new browser
driver=Driver.new()
driver.navigate_to_url("https://www.upwork.com/")

home_page = HomePage.new(driver)
search_page = home_page.search_professional("tester")

freelancers = search_page.extract_freelancers

freelancer_hash = Hash.new()
freelancers.each do |freelancer|
  freelancer_name = search_page.freelancer_name(freelancer).text
  freelancer_title = search_page.freelancer_title(freelancer).text
  puts freelancer_name + " : " + freelancer_title

  freelancer_hash[freelancer_name] = Hash.new()
  freelancer_hash[freelancer_name]['freelancer_title'] = freelancer_title
end

puts freelancer_hash['Julia A.']['freelancer_title']
driver.close_browser
