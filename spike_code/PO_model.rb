# Page object model

def config
  #common Settings
  @browser="chrome"
end

def google_homepage
  #Web Application URL details
  @url="http://google.com"
  #Google Homepage Page Object Models
  @search_field=$browser.text_field(:name,'q')
  @search_button=$browser.div(:class => 'jsb').button(:name => 'btnK')
  sleep 12
end

def bing_homepage
  @url = "http://bing.com"
  @search_field=$browser.text_field(:id,'sb_form_q')
  @search_button=$browser.button(:name => 'go')
end

