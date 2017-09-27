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

puts 'hello'


Recurly.subdomain      = 'kevinpetry'    # 'YOUR-SUBDOMAIN' kevinpetry.recurly.com
Recurly.api_key        = 'cef7538a56794d099b0939e3351f3a08'              # 'YOUR API KEY'


subscription = Recurly::Subscription.create(
  :plan_code => 'bottom-plan',   #free-plan',   #bottom-plan', psy-out-plan
  :currency  => 'USD',     # USD EUR 
  :customer_notes  => 'KLP says Thank you for your business!',
  :account   => { :account_code => 'KLP-01' }, 
 )
account.subscription.save!

10.times { puts '' }
STOP


#https://dev.recurly.com/page/ruby
def method_findAccount(myAccount)
   begin
     #if account does not exist, a NotFound Error will be thrown
     account = Recurly::Account.find myAccount   # i.e. like 'KLP-01'
     # Any subscriptions
     account.subscriptions.each do |theSubscription|
       puts 'Subsciption: ' + theSubscription.uuid.to_s
     end
     account.subscriptions.class

     #subscription will fail because a plan_code is not set
     #subscription = Recurly::Subscription.create!(:account => account)
   rescue Recurly::Resource::NotFound => e
     puts e.message
   rescue Recurly::API::UnprocessableEntity => e
     puts e.message
   else
     puts "Account found. Now, create a subscription"
     return account
   end

end

def method_getSuscriptionCount(account)
   puts ' * method_getSuscriptionCount'
   account.subscriptions.class 
   puts account.subscriptions
   puts ' ===================='
   puts ' - account.subscriptions.count: ' + account.subscriptions.count.to_s
   puts ' - account.subscriptions.entries: ' + account.subscriptions.entries.to_s
   puts ' ==== '
   myArray = account.subscriptions.find_all.to_a
   puts ' - Array count: ' + myArray.length().to_s 
   puts ' DONE' 
end

def method_addSubscription(account,account_code,plan_code)
   puts ' * method_addSubscription'
   puts '   account:   ' + account.to_s
   puts '   plan_code: ' + plan_code.to_s
   puts '   - Minimal required fields'
   account.subscriptions.class
   
   subscription = Recurly::Subscription.create( 
      {
         :plan_code => plan_code,  # 'bottom-plan',   #free-plan',   #bottom-plan',
         :currency  => 'USD',     # USD EUR 
         :customer_notes  => 'KLP has inserted this subscription for account_code: ' + account_code,
         :account   => { :account_code => account_code,
            :billing_info => {
            :verification_value   => 123,
            :number => '4111-1111-1111-1111',
            :month  => 12,
            :year   => 2019 ,
            :country              => 'US', 
            :state                => 'MN',
            :city                 => 'Mankato',
            :address1             => '322 Carney Ave, Suite980',
            :zip                  => '56001' }
      } } )
   subscription.save!
   puts ' - Success: Subscription saved. '
end


def method_availableMethods(myObject)
   puts ' * method_availableMethods'
   puts '   List of methods available. Object: ' + myObject.to_s
   puts myObject.methods.sort
   puts ' '
end   




# MAIN

myAccount='KLP-01'  # KLP-1
# Step 1
account = method_findAccount(myAccount)
account.subscriptions.class
#method_availableMethods(account)
puts '======================================================='
method_getSuscriptionCount(account)
#method_availableMethods(account.subscriptions)

# Step 2
method_addSubscription(account,myAccount,'bottom-plan')  # free-plan, bottom-plan duplicates not allowed

method_getSuscriptionCount(account)

# Step 3

10.times { puts '' }
STOP



puts ' * START: Create subscription'
# For example, take Account -> Invoices
account = Recurly::Account.find('KLP-2')   # The account code. my_account_code')
account.subscriptions.class
puts ' - Account found KLP-2'
puts ''
10.times { puts '' }
STOP
#find the account
account = Recurly::Account.find('KLP-2')



#account.billing_info = {
#  token_id: 'TOKEN_ID'
#}
#account.billing_info.save!
=begin
account.billing_info = {
  :first_name           => 'KLPVerena',
  :last_name            => 'Example',
  :number               => '4111-1111-1111-1111',
  :verification_value   => 123,
  :month                => 11,
  :year                 => 2019,
  # Required
  :country              => 'US', 
  :state                => 'MN',
  :city                 => 'Mankato',
  :address1             => '322 Carney Ave, Suite980',
  :zip                  => '56001'
}
#  account.billing_info.save!

puts ' - billing saved'

subscription = Recurly::Subscription.create(
  :plan_code => 'bottom-plan',   #free-plan',   #bottom-plan',
  :currency  => 'USD',     # USD EUR 
  :customer_notes  => 'KLP says Thank you for your business!',
  :account   => { :account_code => 'KLP-1' }, 
 )
account.subscription.save!


puts ' - Subscription created'
account.subscriptions.each do |theSubscription|
  puts theSubscription.uuid

end



=begin
https://groups.google.com/forum/#!searchin/recurly-api/billing$20info%7Csort:relevance/recurly-api/CgxhzYkowL8/XSiSA_ZqYTMJ
https://groups.google.com/forum/#!searchin/recurly-api/billing$20info%7Csort:relevance/recurly-api/XDzRMUYxENQ/DwteNz5Y8-4J


 subscription_data = {
      'timeframe': "now",
      'account': {
        'account_code': account_id,
        'username': recurly_account['username'],
        'email': recurly_account['email'],
        'first_name': recurly_account['first_name'],
        'last_name': recurly_account['last_name'],
        'billing_info': billing_data
      }
    }

billing_info = Recurly::BillingInfo.new(
          :first_name => self.first_name,
          :last_name => self.last_name,
          :country => self.account.country,
          :credit_card => {
            :number => self.number,
            :year => self.expiry_date.year,
            :month => self.expiry_date.month,
            :verification_value => self.ccv
          }
        )



You can call

account.billing_info = attributes_hash
account.billing_info # => #<Recurly::BillingInfo>
or

account.build_billing_info(attributes_hash) # => #<Recurly::BillingInfo>
or

account.create_billing_info(attributes_hash) # => #<Recurly::BillingInfo>



=end 


puts 'DONE'