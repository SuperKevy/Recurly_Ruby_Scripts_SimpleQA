require 'rubygems'
require 'watir'
require 'rspec'
require 'recurly'

#Demonstrates:  
# 1. Rspec framework. 
# 2. Recurly API calls

#Tests: 
# Test 1. Api subscription count
# Test 2. Api subscription create

#References: 
# Ref: http://artplustech.com/replacing-cucumber-with-rspec-page-object/
# Ref: https://www.youtube.com/watch?v=e9tfC-gLW8c

# *** IMPORTANT. Data to run the tests
# Parameters. For the api tests to run
#  - Note: We expect an unsued plan and a valid account
Recurly.subdomain      = 'kevinpetry'                         # 'YOUR-SUBDOMAIN' kevinpetry.recurly.com
Recurly.api_key        = 'cef7538a56794d099b0939e3351f3a08'   # 'YOUR API KEY'
myAccount = 'KLP-5'                                           # Account_code to use. KLP-2 KLP-01, KLP-5 is valid
myPlanCode = 'test5'                                          # plan_codes = 'test', test2, test, psy-out-plan, 'free-plan',  # 'bottom-plan'   test4, test5


# Code Follows
# Test 1.
# API subscription count
describe "Get the Recurly API subscription count. " do
  account=''
  context 'When a valid account is provided we can test the subcriptions.  ' do
    it " We expect a valid account using Find a valid account using the account.find method. " do
      begin
         account = Recurly::Account.find myAccount   # i.e. like 'KLP-01'
         #puts " - INFO: Account: #{account.inspect}"
         rescue Recurly::Resource::NotFound => e
            puts e.message
            expect(e.message).to eq myAccount
         rescue Recurly::API::UnprocessableEntity => e
            puts e.message
         rescue Recurly::Resource::Invalid => e
            puts e.message
         else
            #puts " - INFO: account_code: #{account.account_code.to_s}. "
            expect(account.account_code.to_s).to eq myAccount
      end
    end
  end

  context "With a valid account found we can get account subscription count. " do
     it "We expect that using account.subscriptions.count returns 0 or greater. " do
        begin
           #account.subscriptions.class
           theCount = account.subscriptions.count
           #puts " "
           #puts " - INFO: Account: #{myAccount} has #{theCount.to_s} suscriptions. "
           expect(theCount).to be >= 0
        end
     end
  end
end

# Test 2 
# API subscription create
describe "Create a subscription using theSubscription API. " do
   #account=''
  context 'A valid account_code, unused plan_code and required billing information can create a subscription. ' do
     it('We expect the subscription API to return true when a new subscription is created. ') do
        begin
           #puts ' '
           subscription = Recurly::Subscription.create( 
           {
              :plan_code => myPlanCode,  # 'bottom-plan',   #free-plan',   #bottom-plan',
              :currency  => 'USD',     # USD EUR 
              :customer_notes  => 'KLP has inserted this subscription via the API. ',
              :account   => { 
                 :account_code => myAccount,
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
           response = subscription.save!
           rescue Recurly::Resource::NotFound => e
              puts e.message
           rescue Recurly::API::UnprocessableEntity => e
              puts e.message
           rescue Recurly::Resource::Invalid => e
              puts e.message
              expect(e.message).not_to  include "You already have a subscription to this plan."
           else
              #puts " - INFO: Subscription successfully created. "
              expect(response).to be true
         end
     end
  end
end


