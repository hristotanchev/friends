require 'spec_helper'

describe "StaticPages" do
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title full_title(page_title) }
  end

  context "Home page" do
    before { visit root_path }
    let(:heading) { 'Friends App' }
    let(:page_title) { '' }

    it { should_not have_title '| Home' }
  end

  context "Help page" do
    before { visit help_path }
    let(:heading) { 'Friends App' }
    let(:page_title) { 'Help' }
  end
  
  context "Aboute page" do
    before { visit about_path }
    let(:heading) { 'Friends App' }
    let(:page_title) { 'About Us' }
  end

  context "Contact page" do
    before { visit contact_path }
    let(:heading) { 'Friends App' }
    let(:page_title) { 'Contact' }
  end

  it "should have right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "friends app"
    expect(page).to have_title(full_title(''))
  end
end
