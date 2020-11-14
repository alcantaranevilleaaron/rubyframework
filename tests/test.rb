require_relative '../pageobjects/home_page.rb'

# testdata
keyword = "tester"
url = "https://www.upwork.com/"

# create new instance of driver class
# 1. Run browser
# 2. Clear browser cookies
# 3. Navigate to url "https://www.upwork.com/"
driver = Driver.new()
driver.navigate_to_url(url)

# create new instance of home_page class and passing the driver in its constructor
# 4. Focus onto "Find professional & agencies"
# 5. Enter <keyword> and submit by clicking the magnifying glass button
# this will now create a new instance of search_page which stores the results from our query
home_page = HomePage.new(driver)
search_page = home_page.search_professional(keyword)

# 6. Parse the first page with the results and attributes of each freelancer and store in a nested hash
freelancer_hash = search_page.extract_freelancers_info
freelancer_keys = freelancer_hash.keys

puts "Size of result: " + freelancer_hash.length.to_s
puts freelancer_keys[5]
puts freelancer_hash[freelancer_keys[5]]['freelancer_title']
puts freelancer_hash[freelancer_keys[5]]['freelancer_overview']
puts freelancer_hash[freelancer_keys[5]]['freelancer_skills']

driver.close_browser
