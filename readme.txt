This is a Selenium Project written in Ruby following the Page Object Design Pattern

1. This was created and tested using RubyMine and Windows Machine. 
2. Configuration file is under resources\config\config.yml:
	a. browser: acceptable values are chrome and firefox for now
	b. url: url of the site that needs to be tested (can point to dev, uat or prod environment)
	c. timeout: defined timeout for element search (in seconds)
	d. captcha_wait: defined sleep time for the script while completing captcha (in seconds
3. Test data is stored under resources\testdata\keywords.txt (Note: For this task, this file will only accept one word as input)
