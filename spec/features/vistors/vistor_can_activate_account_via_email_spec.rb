require 'rails_helper'

describe 'Visitor' do
  it "visitor gets flash notice that email was sent and they can activate account from link provided" do
    visit '/'
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'
    token = ENV["GH_API_KEY"]
    click_on 'Register'

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on "Create Account"
    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Logged in as #{first_name} #{last_name}. This account has not yet been activated. Please check your email.")
  end


end
