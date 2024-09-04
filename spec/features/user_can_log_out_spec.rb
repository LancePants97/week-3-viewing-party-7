require 'rails_helper'

RSpec.describe "Logging Out" do
  it "can log out after being logged in" do
    user = User.create(name: "funbucket13", email: "420blazeit@railsapp.com", password: "test", password_confirmation: "test")
    visit root_path

    click_on "Log In"

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    fill_in :location, with: "New Jersey"

    click_on "Log In"
    expect(current_path).to eq(user_path(user))

    click_on "Log Out"
    expect(current_path).to eq(root_path)
    expect(page).to have_content("You have been logged out.")

    expect(page).to have_link("Log In")
    expect(page).to have_button("Create New User")
    expect(page).to_not have_link("Log Out")

  end
end