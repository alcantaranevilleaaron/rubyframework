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

# 8. Click on random freelancer's title
freelancer_page = search_page.view_freelancer(freelancer_name)

# 9. Get into the freelancer's profile and extract the information into a hash
freelancer_profile = freelancer_page.extract_freelancer_info

# 10. Compare attribute values from step #6
# 11. Check whether the profile attribute value contains <keyword>
freelancer_search = freelancer_hash[freelancer_name]
freelancer_profile.each do |freelancer_profile_attr, freelancer_profile_attr_value|
  puts "search attr:  " + freelancer_search[freelancer_profile_attr]
  puts "profile attr: " + freelancer_profile_attr_value

  match_keyword = " DOES NOT MATCH"
  if freelancer_search[freelancer_profile_attr].eql?(freelancer_profile_attr_value)
    match_keyword = " DOES MATCH"
  end
  puts freelancer_profile_attr + match_keyword

  contain_keyword = ' DOES NOT CONTAIN '
  if driver.contains_ignore_case(freelancer_profile_attr_value, keyword)
    contain_keyword = ' CONTAINS '
  end
  puts freelancer_profile_attr_value + contain_keyword + keyword
end

driver.close_browser
