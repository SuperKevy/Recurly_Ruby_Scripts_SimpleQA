require 'watir'
require './spec/PO_model.rb'

#Ref: https://raveendran.wordpress.com/2011/05/31/page-object-model-for-watir-webdriver/

config
  $browser = Watir::Browser.new @browser.to_sym

google_homepage
  $browser.goto @url
  @search_field.set("Raveendrantir Webdriver")
  @search_button.click
  puts $browser.title

bing_homepage
  $browser.goto @url
  @search_field.set("Raveendrantir Webdriver")
  @search_button.click
  puts $browser.title

  $browser.close