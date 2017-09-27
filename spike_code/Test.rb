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

# To set a default currency for your API requests:
Recurly.default_currency = 'USD'
puts ' - PASS: Currency Set - this simply confirms a good connection.'

# Now find any existing subscription. 

subscription = Recurly::Subscription.find('401ab0d0aaefb77b331f8340dda4d170')   #Key is visible in the UI. returns a subscription string XML?
puts subscription.activated_at             # => 2008-03-01T13:00:00Z?
6.times { puts '' }

puts subscription.methods.sort


#6.times {puts ''}
#STOP

Recurly::Subscription.find_each do |subscription|p
   puts "Susbcription: #{subscription}"
   3.times {puts '' }
   puts "UUID: #{subscription.uuid}"
end


10.times {puts ''}
#STOP



3.times { puts '' }
puts ' - Disabled Start of Invoice paging test. '
# find_each will fetch the pages for you
# until there are none left. It presents
# all the invoices on the server as a single enumerable
#Recurly::Invoice.paginate(opts).find_each do |invoice|
#  puts ' - INVOICE: '
#  puts invoice.invoice_number
#end

# You can also use #find_each directly on the resource3.tyimes
#Recurly::Invoice.find_each do |invoice|
#  puts 'Invoice Number: ' + invoice.invoice_number.to_s
#end
puts ' ==== END part 1 ==='


# For example, take Account -> Invoices
account = Recurly::Account.find('KLP-01')   # The account code. my_account_code')

3.times { puts ''}
puts ' - Start. Test for invoices'
account.invoices.class
#=> Recurly::Resource::Pager

# Pager#each can be used to iterate through the only the given page
account.invoices.each do |invoice|
  puts invoice.invoice_number
end
puts ' - End. Test for invoices'



3.times { puts ''}
puts ' - Start. Test for suscriptions'
account.subscriptions.class
#=> Recurly::Resource::Pager
# Pager#each can be used to iterate through the only the given page

account.subscriptions.each do |theSubscription|
  puts theSubscription.uuid

end
puts ' - End. Test for subscriptions'

#10.times { puts '' }
#STOP

3.times { puts '' }
puts ' * START: Create subscription'

subscription = Recurly::Subscription.create(
  :plan_code => 'bottom-plan',
  :currency  => 'USD',     # USD EUR 
  :customer_notes  => 'KLP says Thank you for your business!',
  :account   => {
    :account_code => 'KLP-1',
    :email        => '72627.2200@compuserve.com ',
    :first_name   => 'XVerena',
    :last_name    => 'XExample',
    :billing_info => {
      :number => '4111-1111-1111-1111',
      :month  => 12,
      :year   => 2019,
    }
  },
  # gift_card: Recurly::GiftCard.new(redemption_code: redemption_code)
)

account.subscriptions.each do |theSubscription|
  puts theSubscription.uuid

end


#### GET SUBSCRIPTIONS
#puts ' - Get subscriptions '
#mySubscriptions = Recurly_SubscriptionList::getForAccount('KLP-1')
#mySubscriptions.each |theSubscription|
#   puts 'theSubscription'
#end



#6.times { puts '' }
#puts ' done' 
#STOP
# Recurly gem documentation
# see https://github.com/recurly/recurly-client-ruby
#https://stackoverflow.com/questions/28542671/how-to-gernerate-recurly-api-key-implementing-with-ruby
#account = Recurly::Account.create( 
#                      :account_code => '1', 
#                      :email => 'verena@notanemailplace.com', 
#                      :first_name => 'Verena', 
#                      :last_name => 'Example' )
#                      
                      

####
#Recurly::Subscription.create! plan_code: :monthly_subscription,
#  account: {
#    account_code: 'KLP-1',
#    currency: 'USD',
#    billing_info: { token_id: 'TOKEN_ID' }
#  }
        
#####


        
puts 'done'     


# Good info https://dev.recurly.com/docs/pagination


#https://docs.recurly.com/v1.0/docs/email-templates#section-subscription-and-add-on-fields   The field list

# Suscription
'- account_code 
'- plan_code 
'- quantity 
'- signature 