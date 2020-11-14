class FreelancerPage

  def initialize(driver)
    @driver = driver
  end

  def freelancer_profile_slider
    @driver.find_element(:css, "div[class='profile-viewer-slider']")
  end

  def freelancer_identity_content
    @driver.find_child_element(freelancer_profile_slider, :css, "div[class='identity-content']")
  end

  def freelancer_name
    @driver.find_child_element(freelancer_identity_content, :css, "h1[itemprop='name']")
  end

  def freelancer_body
    @driver.find_child_element(freelancer_profile_slider, :css, "section[class='row']")
  end

  def freelancer_summary
    @driver.find_child_element(freelancer_body, :css, "section[class='up-card-section py-30']")
  end

  def freelancer_title
    @driver.find_child_element(freelancer_summary, :css, "h2[role='presentation']")
  end

  def freelancer_overview
    @driver.find_child_element(freelancer_summary, :css, "span[class='text-pre-line break']")
  end

  def freelancer_skills
    @driver.find_child_element(freelancer_profile_slider, :css, "div[class='skills']")
  end

  def extract_freelancer_info
    freelancer_info_name = freelancer_name.text
    freelancer_info_title = freelancer_title.text
    freelancer_info_overview = freelancer_overview.text
    freelancer_info_skills = freelancer_skills.text

    freelancer_hash = {}
    freelancer_hash['freelancer_title'] = freelancer_info_title
    freelancer_hash['freelancer_overview'] = freelancer_info_overview.gsub("\n", ' ')
    freelancer_hash['freelancer_skills'] = freelancer_info_skills.gsub("\n", ',').sub!('Skills,', '')

    return freelancer_hash
  end

end