require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :name, with: 'Bob'
    fill_in :email, with:'user1@example.com'
    fill_in :password, with: "password123"
    fill_in :password_confirmation, with: "password123"
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))

    expect(page).to have_content("Bob's Dashboard")
  end 

  it 'does not create a user if email isnt unique' do 
    User.create!(name: 'User One', email: 'notunique@example.com', password: "password123", password_confirmation: "password123")

    visit register_path
    
    fill_in :name, with: 'Rob'
    fill_in :email, with:'notunique@example.com'
    fill_in :password, with: "heyhey420"
    fill_in :password_confirmation, with: "heyhey420"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  it "does not create a user if 'name' field is empty" do 
    User.create!(name: 'User One', email: 'notunique@example.com', password: "password123", password_confirmation: "password123")

    visit register_path
    
    # fill_in :name, with: 'Rob'
    fill_in :email, with:'notunique@example.com'
    fill_in :password, with: "heyhey420"
    fill_in :password_confirmation, with: "heyhey420"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Name can't be blank")
  end

  it "does not create a user if 'email' field is empty" do 
    User.create!(name: 'User One', email: 'notunique@example.com', password: "password123", password_confirmation: "password123")

    visit register_path
    
    fill_in :name, with: 'Rob'
    # fill_in :email, with:'notunique@example.com'
    fill_in :password, with: "heyhey420"
    fill_in :password_confirmation, with: "heyhey420"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email can't be blank")
  end


  it "does not create a user if 'password' field is empty" do 
    User.create!(name: 'User One', email: 'notunique@example.com', password: "password123", password_confirmation: "password123")

    visit register_path
    
    fill_in :name, with: 'Rob'
    fill_in :email, with:'notunique@example.com'
    # fill_in :password, with: "heyhey420"
    fill_in :password_confirmation, with: "heyhey420"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password can't be blank")
  end

  it "does not create a user if 'password confirmation' field is empty" do 
    User.create!(name: 'User One', email: 'notunique@example.com', password: "password123", password_confirmation: "password123")

    visit register_path
    
    fill_in :name, with: 'Rob'
    fill_in :email, with:'notunique@example.com'
    fill_in :password, with: "heyhey420"
    # fill_in :password_confirmation, with: "heyhey420"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password confirmation can't be blank")
  end
end
