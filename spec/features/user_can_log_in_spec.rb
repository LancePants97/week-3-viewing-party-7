require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials (email and password)" do
    user = User.create(name: "funbucket13", email: "420blazeit@railsapp.com", password: "test", password_confirmation: "test")

    visit root_path

    click_on "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation

    click_on "Log In"

    expect(current_path).to eq(user_path(user))

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it "cannot log in with wrong email" do
    user = User.create(name: "funbucket13", email: "420blazeit@railsapp.com", password: "test", password_confirmation: "test")

    visit login_path

    fill_in :email, with: "beepboop@robot.org"
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
  
    click_on "Log In"
  
    expect(current_path).to eq(login_path)
  
    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  it "cannot log in with wrong password" do
    user = User.create(name: "funbucket13", email: "420blazeit@railsapp.com", password: "test", password_confirmation: "test")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: "incorrect password"
    fill_in :password_confirmation, with: user.password_confirmation
  
    click_on "Log In"
  
    expect(current_path).to eq(login_path)
  
    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  it "cannot log in with wrong password confirmation" do
    user = User.create(name: "funbucket13", email: "420blazeit@railsapp.com", password: "test", password_confirmation: "wrongpassword")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
  
    click_on "Log In"
  
    expect(current_path).to eq(login_path)
  
    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  it "can implement a cookie for remembering location" do
    user = User.create(name: "funbucket13", email: "420blazeit@railsapp.com", password: "test", password_confirmation: "test")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    fill_in :location, with: "New Jersey"

    click_on "Log In"
    expect(current_path).to eq(user_path(user))

    click_on "Log Out"

    expect(current_path).to eq(login_path)

    expect(page).to have_field("Location", with: "New Jersey")
  end
end