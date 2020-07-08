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

    fill_in :email, with: email
    fill_in :first_name, with: first_name
    fill_in :last_name, with: last_name
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_on "Submit"

    expect(path).to eq("/dashboard")
    expect(page).to have_content("Logged in as #{first_name} #{last_name}. This account has not yet been activated. Please check your email.")
    click_on 'Sign up now.'
  end


end
