Simple Recurly automation testing sample. The environment is ruby testing with rspec, watir, page objects, and a recurly test account.
The tests run via rspec.  The spec_helper.rb file was autogenerated with spec --init. It uses the default helper. 
You will need a recurly account to run the rspec tests.
There are two scripts to meet the test requirements. 1) SubscriptionExample_browser-api.rb. 2) SubscriptionExample_Count_Create-api.rb. Data parameters are set within the scripts.
The tests were originally created in the windows environment and run via TextPad.  

About the tests: 1) Use Recurly�s API to create subscriptions. 2. Use the subscriptions that you have created to test the subscription counts on the /subscriptions page (Customers > Subscriptions.) 3. Use the subscriptions that you have created to test the subscriptions page search widget at the top of (Customers > Subscriptions.) Bonus points for: Ability to write UI test automation, 1) Ability to write API automation. 2) Use of a testing framework like RSpec, Test-Unit, TestNG or pytest. 3) Test reusability: How the code is organized. 4) Find a bug (either from automation or exploratory testing on Recurly-app). 5) Making your submission available via github/gitlab, bitbucket etc 