require "rubygems"
require 'watir'
require 'rspec'
#require "./spec/spec_helper.rb"

puts 'start'

describe "Google" do
  before { goto "http://google.com" }

  it "has search box" do
    expect(text_field(name: "q")).to be_present
  end

  it "allows to search" do
    text_field(name: "q").set "watir"
    button(id: "kevin").click
    #button(id: "gbqfb").click
    results = div(id: "ires")
    expect(results).to be_present.within(2)
    expect(results.lis(class: "g").map(&:text)).to be_any { |text| text =~ /watir/ }
    expect(results).to be_present.during(1)
  end
end

puts 'done'

