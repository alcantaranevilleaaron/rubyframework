class SearchResultPage

  def initialize(driver)
    @driver = driver
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

end