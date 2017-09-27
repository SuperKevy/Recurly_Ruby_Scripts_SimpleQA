require 'rubygems'
require 'recurly'

Recurly.subdomain      = 'kevinpetry'    # 'YOUR-SUBDOMAIN' kevinpetry.recurly.com
Recurly.api_key        = 'cef7538a56794d099b0939e3351f3a08'              # 'YOUR API KEY'

plan_code = 'bottom_plan'
account_code = 'KLP-01'
# To set a default currency for your API requests:
Recurly.default_currency = 'USD'
 puts 'hello'
# https://[subdomain].recurly.com/v2/accounts


#https://dev.recurly.com/page/ruby
def method_one()
   begin
     #if account does not exist, a NotFound Error will be thrown
     account = Recurly::Account.find 'KLP-01'

     #subscription will fail because a plan_code is not set
     #subscription = Recurly::Subscription.create!(:account => account)
     
     subscription = Recurly::Subscription.create(
       :plan_code => 'bottom',
       :currency  => 'USD',
       :customer_notes  => 'Thank you for your business!',
       :account   => {
         :account_code => '1',
         :email        => 'verena@example.com',
         :first_name   => 'Verena',
         :last_name    => 'Example',
         :billing_info => {
           :number => '4111-1111-1111-1111',
           :month  => 1,
           :year   => 2014,
         }
       },
       :shipping_address => {
         :nickname   => 'Work',
         :first_name => 'Verena',
         :last_name  => 'Example',
         :company    => 'Recurly Inc',
         :phone      => '555-222-1212',
         :email      => 'verena@example.com',
         :address1   => '123 Main St.',
         :address2   => 'Suite 101',
         :city       => 'San Francisco',
         :state      => 'CA',
         :zip        => '94105',
         :country    => 'US'
       }
)
     
     
   rescue Recurly::Resource::NotFound => e
     puts e.message
   rescue Recurly::API::UnprocessableEntity => e
     puts e.message
   else
     puts "Successfully Created"
   end

method_one()

end