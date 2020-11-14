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

# 7. Check whether the attributes does have the <keyword> in it
freelancer_hash.each do |freelancer_name, freelancer_info|
  puts freelancer_name
  freelancer_info.each do |freelancer_attr, freelancer_attr_value|
    contain_keyword = ' DOES NOT CONTAIN '
    if driver.contains_ignore_case(freelancer_attr_value, keyword)
      contain_keyword = ' CONTAINS '
    end
    puts freelancer_attr + contain_keyword + keyword
  end
  puts ''
end

random = rand(freelancer_hash.length)
freelancer_name = freelancer_keys[random]

freelancer_page = search_page.view_freelancer(freelancer_name)

puts freelancer_page.freelancer_name.text
puts freelancer_page.freelancer_title.text
puts freelancer_page.freelancer_overview.text
puts freelancer_page.freelancer_skills.text

driver.close_browser
