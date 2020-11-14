require_relative '../pageobjects/home_page.rb'

#define new browser
driver=Driver.new()
driver.navigate_to_url("https://www.upwork.com/")

home_page = HomePage.new(driver)
search_page = home_page.search_professional("tester")

freelancer_hash = search_page.extract_freelancers_info
freelancer_keys = freelancer_hash.keys

puts freelancer_keys[5]
puts freelancer_hash[freelancer_keys[5]]['freelancer_title']
puts freelancer_hash[freelancer_keys[5]]['freelancer_overview']
puts freelancer_hash[freelancer_keys[5]]['freelancer_skills']

driver.close_browser
