require_relative '../pageobjects/freelancer_page'

class SearchResultPage

  def initialize(driver)
    @driver = driver
  end

  def header
    @driver.find_element(:css, "h1[class^='top-freelancers']")
  end

  def extract_freelancers
    @driver.find_elements(:css, "div[class='up-card-section up-card-hover']")
  end

  def freelancer_name(freelancer)
    @driver.find_child_element(freelancer, :css, "div[class='identity-name']")
  end

  def freelancer_title(freelancer)
    @driver.find_child_element(freelancer, :css, "p[class='my-0 freelancer-title']")
  end

  def freelancer_overview(freelancer)
    @driver.find_child_element(freelancer, :css, "p[class='overview mb-0']")
  end

  def freelancer_skills(freelancer)
    @driver.find_child_element(freelancer, :css, "div[class='up-skill-container attr-skill group']")
  end

  def view_freelancer(freelancer_name)
    $stdout.puts "Clicking " + freelancer_name + " profile link"
    @driver.find_elements(:css, "div[class='identity-name'").select { |el| el.text == freelancer_name}.first.click
    FreelancerPage.new(@driver)
  end

  def extract_freelancers_info
    $stdout.puts "Parsing freelancer_name, freelancer_title, freelancer_overview, freelancer_skills and storing it in a nested hash."
    freelancers = extract_freelancers

    freelancer_hash = {}
    freelancers.each do |freelancer|
      freelancer_name = freelancer_name(freelancer).text
      freelancer_title = freelancer_title(freelancer).text
      freelancer_overview = freelancer_overview(freelancer).text
      freelancer_skills = freelancer_skills(freelancer).text

      freelancer_hash[freelancer_name] = {}
      freelancer_hash[freelancer_name]['freelancer_title'] = freelancer_title
      freelancer_hash[freelancer_name]['freelancer_overview'] = freelancer_overview
      freelancer_hash[freelancer_name]['freelancer_skills'] = freelancer_skills.gsub("\n", ',')
    end
    return freelancer_hash
  end

end