require 'spec_helper'

describe "StaticPages" do

  context "Home page" do

    it "Contents Friends" do
      visit '/static_pages/home'
      expect(page).to have_content 'Friends'
    end

    it "should have the right title" do
		  visit '/static_pages/home'
		  expect(page).to have_title("Friends App | Home")
		end
  end

  context "Help page" do

    it "Contents Help" do
      visit '/static_pages/help'
      expect(page).to have_content 'Help'
    end

    it "should have the right title" do
		  visit '/static_pages/help'
		  expect(page).to have_title("Friends App | Help")
		end
  end
  
  context "Aboute page" do

    it "Contents Aboute Us" do
      visit '/static_pages/about'
      expect(page).to have_content 'Aboute Us'
    end

    it "should have the right title" do
		  visit '/static_pages/about'
		  expect(page).to have_title("Friends App | About")
		end
  end

  context "Contact page" do

    it "Contents Contact" do
      visit '/static_pages/contact'
      expect(page).to have_content 'Contact'
    end

    it "should have the right title" do
      visit '/static_pages/contact'
      expect(page).to have_title("Friends App | Contact")
    end
  end
end
