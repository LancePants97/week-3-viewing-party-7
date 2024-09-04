require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    user1 = User.create(name: "User One", email: "user1@test.com")
    user2 = User.create(name: "User Two", email: "user2@test.com")
  end 

  it 'has a header' do
    visit root_path
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    visit root_path
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  it 'lists out existing users' do 
    user = User.create!(name: "funbucket13", email: "420blazeit@railsapp.com", password: "test", password_confirmation: "test")
    user1 = User.create!(name: "User One", email: "user1@test.com", password: "poop", password_confirmation: "poop")
    user2 = User.create!(name: "User Two", email: "user2@test.com", password: "poop", password_confirmation: "poop")
    visit root_path
    
    click_on "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation

    click_on "Log In"
    expect(current_path).to eq(user_path(user))

    visit root_path
    expect(page).to have_content('Existing Users:')

    within('.existing-users') do 
      expect(page).to have_content(user1.email)
      expect(page).to_not have_link(user1.email)
      expect(page).to have_content(user2.email)
      expect(page).to_not have_link(user2.email)
    end     
  end 

  it "does not display list of existing users if you are not logged in" do
    visit root_path
    expect(page).to_not have_content("Existing Users")
  end
end
