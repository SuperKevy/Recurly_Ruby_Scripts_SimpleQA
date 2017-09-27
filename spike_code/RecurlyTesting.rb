# ruby sample
# Coding Challenge:
# 1. Use Recurly’s API to create subscriptions.
# 2. Use the subscriptions that you have created to test the subscription counts on the /subscriptions page (Customers > Subscriptions.)
# 3. Use the subscriptions that you have created to test the subscriptions page search widget at the top of (Customers > Subscriptions.)
# Bonus points for:
# • Ability to write UI test automation.
# • Ability to write API automation.
# • Use of a testing framework like RSpec, Test-Unit, TestNG or pytest.
# • Test reusability: How the code is organized.
# • Find a bug (either from automation or exploratory testing on Recurly-app)  
# • Making your submission available via github/gitlab, bitbucket etc


#===========================================
# Start here: 
# https://dev.recurly.com/page/ruby
#                                           
#===========================================


require 'rubygems'
require 'recurly'

#https://dev.recurly.com/page/ruby

puts 'hello'


Recurly.subdomain      = 'kevinpetry'    # 'YOUR-SUBDOMAIN' kevinpetry.recurly.com
Recurly.api_key        = 'cef7538a56794d099b0939e3351f3a08'              # 'YOUR API KEY'


account = Recurly::Account.find 'KLP-3'   # i.e. like 'KLP-01'
puts account
account.subscriptions.class 


 subscription = Recurly::Subscription.create( 
      {
         :plan_code => 'psy-out-plan',  # Available psy-out-plan',  # 'bottom-plan',   #free-plan',   #bottom-plan',klpplan test, test2
         :currency  => 'USD',     # USD EUR 
         :customer_notes  => 'KLP has inserted this subscription for account_code ',
         :account   => { 
            :account_code => 'KLP-5',
            :billing_info => {
            :number => '4111-1111-1111-1111',
            :month  => 12,
            :year   => 2019,
            # if the billing is not provided we need to add this data to ensure a save
            :verification_value   => 123,
            :country              => 'US', 
            :state                => 'MN',
            :city                 => 'Mankato',
            :address1             => '322 Carney Ave, Suite980',
            :zip                  => '56001' 
     } } } )
   subscription.save!
   puts ' - Success: Subscription saved. '



