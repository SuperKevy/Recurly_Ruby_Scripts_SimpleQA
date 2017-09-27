require 'rubygems'
require 'watir'
require 'rspec'
require 'recurly'

Recurly.subdomain      = 'kevinpetry'    # 'YOUR-SUBDOMAIN' kevinpetry.recurly.com
Recurly.api_key        = 'cef7538a56794d099b0939e3351f3a08'              # 'YOUR API KEY'
myAccount = 'KLP-1'

describe "Google" do

  before :all do
    @browser = Watir::Browser.new( :chrome )
    @browser.goto "http://google.com"
    puts 'Browser text include Google? ' + @browser.text.include?('Google').to_s
    puts 'Browser title: ' + @browser.title.to_s
  end

  it "has word 'Google' on main page" do
    expect(@browser.text).to include("Google")
  end

  it "has word 'Bing' as it's title" do
    expect(@browser.title).to eq "Google"
  end

  after :all do
    @browser.close
  end

end

describe "Get the Recurly subscription count." do
   it "The subscription count must be greater then zero" do
     begin
      account = Recurly::Account.find myAccount   # i.e. like 'KLP-01'
      account.subscriptions.class 
      theCount = account.subscriptions
      end
   end
end

describe "Recurly Create API test" do

  it('Subscription API create should return a 200') do
      begin
       subscription = Recurly::Subscription.create( 
            {
               :plan_code => 'free-plan',  # 'bottom-plan',   #free-plan',   #bottom-plan',
               :currency  => 'USD',     # USD EUR 
               :customer_notes  => 'KLP has inserted this subscription for account_code KLP-3',
               :account   => { 
                  :account_code => 'KLP-5',
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
            puts ' - response: ' + response.to_s
            expect(response ).to eq false
            puts ' Done with test'
            rescue Recurly::Resource::NotFound => e
              puts e.message
            rescue Recurly::API::UnprocessableEntity => e
              puts e.message
            else
              puts "Successfully Created"
            end

  end
end