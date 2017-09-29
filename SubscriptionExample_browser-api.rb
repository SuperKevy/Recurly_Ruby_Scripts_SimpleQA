require 'rubygems'
require 'watir'
require 'rspec'
require 'recurly'
require 'uri'

#Ref: http://artplustech.com/replacing-cucumber-with-rspec-page-object/
#Ref: https://www.youtube.com/watch?v=e9tfC-gLW8c
#Ref: https://github.com/cheezy/page-object/wiki/Get-me-started-right-now!
# PageObject is just an interface to a Page so avoid putting assertions in there
# Assertions live inside of RSpec feature to promote readability of the feature spec
# Avoid adding too much business logic in Page Objects
# Have a clear convention around components, such as footer or header, that are available on every pages

# Demonstrates: 
# 1. the Watir (chrome) browser driven test. 
# 2. thepage object model
# 3. rspec framework
# 4. page objects
# 5. recurly pager API call
# 6. recurly subscription count API call

# *** IMPORTANT. Data to run the tests
# Test 1 Parameters. For the api test to run
Recurly.subdomain      = 'soacedesk'                                     # 'YOUR-SUBDOMAIN' spacedesk.recurly.com
Recurly.api_key        = 'YOUR API KEY'                                  # 'YOUR API KEY'  like 'cef7538a56794d099b0939e3351f3a08' 

# Test 2 Parameters. For the browser test to run
myUserEmail = 'coolone8384@gmail.com'                                    # YOOR recurly login email address
myUserPassword = 'sornado_bullseye'                                      # YOUR plan_code found in the configuration plans
mySearchPlan = 'free'                                                    # Plan_code partial match is valid
myAccount = 'KLP-2'                                                      # YOUR Recurly account to search

#Test code begins
# **************************************************
#Test 1. recurly_APISubscriptionInfo.
# Just verbose suscription info to the output window
# Demonstrates the recurly pager object.
def recurly_APISubscriptionInfo()
  puts ' * recurly_APISubscriptionInfo'
  # Pagination in the ruby client is done using
  # the Recurly::Pager class.

  # You can also create a Pager directly from any resource
  Recurly::Subscription.paginate.class
  #=> Recurly::Resource::Pager

  # paginate optionally takes the sorting and filtering params
  # if you want to specify them
  opts = {
    begin_time: DateTime.new(2016,1,1),
    end_time: DateTime.new(2035,1,1),
    #state: :collected,
    per_page: 300
  }

  # find_each will fetch the pages for you
  # until there are none left. It presents
  # all the subscription on the server as a single enumerable
  # Push all the uuid-s to an array for listing.
  puts ' ' 
  puts ' - All subscription uuid-s '
  mySubscriptions = []
  Recurly::Subscription.paginate(opts).find_each do |subscription|
    puts subscription.uuid.to_s  #.invoice_number
    mySubscriptions.push(subscription.uuid.to_s)  
  end
  puts " - End of list"
  puts " " 
  puts "  - Number of subscriptions: " + mySubscriptions.length().to_s
  # Now get the first /each/ subscription minimal details
  puts '  - Every subscriptions details '
  mySubscriptions.each do | theSubscription | 
    puts ' - Find: ' + theSubscription.to_s
    subscription = Recurly::Subscription.find( theSubscription.to_s )  #by uuid ('4028618e3d55d0862b6bb04194baef72')
    puts '   - uuid: ' + subscription.uuid.to_s  #.invoice_number
    puts '   - plan_code: ' + subscription.plan_code.to_s
    puts '   - customer_notes: ' + subscription.customer_notes.to_s
    puts '   - collection_method: ' + subscription.collection_method.to_s
    puts '   - state: ' + subscription.state.to_s
    puts ' '
  end
  #
  puts '     - Return: true - Pager found data.'
  return true
end    


# Test 2
# Define the page objects
def recurly_LoginPage
  @url = "https://app.recurly.com/login"
  #@url="http://google.com"
  @user_email = $browser.text_field( :id => 'user_email')
  @user_password = $browser.text_field( :id => 'user_password')
  @submit_button = $browser.button( :id => 'submit_button')
  @validate_login = $browser.link(:text,'Log Out').present?
end

def recurly_Navigate
  #puts ' * recurly_Navigate'
  @validate_login = $browser.link(:text,'Log Out').present?
end

def recurly_SubscriptionsWidget
  #puts ' * recurly_SubscriptionsWidget'
  #puts '   - Current URL: ' + $browser.url.to_s
  uri = URI.parse($browser.url.to_s)
  #puts '   - Root host: ' + uri.host.to_s
  #puts "   - Subscription path: " + " https://" + uri.host.to_s + "/subscriptions"
  @widget_Url = "https://" + uri.host.to_s + "/subscriptions"
  @widget_text = $browser.text_field( :id => 'q' )
  @widget_button = $browser.button( :class => 'Search-button' )
end


#Rspec tests are here
#We have two tests to be brief. 
# Test 1 is an api test of the subscription pager class. 
# Test 2 is an api test to return the subscription count.
# Test 3 is a browser test of subscription search.

# Test 1
# Recurly Pager API, rspec
describe "API test of the subscriptions and subscription object. " do
  context "It displays the following verbose subscription information using the pager api. " do
    it "We expect it to always return true. " do
      myResult = recurly_APISubscriptionInfo()
      #puts myResult.to_s
      expect(myResult).to eq true
    end
  end
end

# Test 2
# Recurly API call for subscription count
describe "Get the Recurly subscription count via API. " do
  context "When a valid account is provided the API can be queried for subscription count. " do
   it "We expect a subscription count must be greater or equal to zero. " do
      account = Recurly::Account.find myAccount   # i.e. like 'KLP-01'
      account.subscriptions.class 
      expect(account.subscriptions.count).to be >= 0
   end
  end   
end

# Test 3
# page objects, rspec, browser automation.
# Find a subscription plan
describe "Browser test of the subscription search " do
  before do
    $browser = Watir::Browser.new :chrome
  end
  context "Launch browser, Log in, Navigate to subscription and search for subscriptions. " do
    it "We expect the Displaying message to display below the subscription table. " do
        recurly_LoginPage
          #puts ' * PO recurly_LoginPage'
          $browser.goto @url
          @user_email.set( myUserEmail )
          @user_password.set( myUserPassword )
          @submit_button.click
          @validate_login
          #puts '  - browser.title ' + $browser.title.to_s
          #puts '  - Log Out present? ' + $browser.link(:text,'Log Out').present?.to_s
          expect($browser.link(:text,'Log Out').present?).to eq true
    
        recurly_Navigate 
          #puts ' * PO recurly_Navigate'
          #puts '   - Currently extraneous & pending. '
          #puts '   - Logout Present: ' + $browser.link(:text,'Log Out').present?.to_s
          #puts '   - Current URL: ' + $browser.url.to_s
          expect($browser.link(:text,'Log Out').present?).to eq true
          
        recurly_SubscriptionsWidget
          #puts ' * PO recurly_SubscriptionsWidget'
          #puts '   - Subscription URL: ' + @widget_url.to_s
          $browser.goto @widget_Url
          @widget_text.set( mySearchPlan  )  # 'free')
          @widget_button.click
          #puts '   - Result: ' +  $browser.div( :class => 'Pagination-left').text.to_s
          expect($browser.div( :class => 'Pagination-left').text.to_s).to include('Displaying')
     end
  end
  
  after do
    $browser.close if $browser
  end

end
