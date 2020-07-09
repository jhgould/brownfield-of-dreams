require 'rails_helper'

describe 'Email invitations' do

  before :each do
    @user = create(:user, token: ENV["GH_API_KEY"])
    @user_2 = create(:user, token: ENV["2_GH_API_KEY"], login: "jhgould")
  end

  it "user can send invite" do

    visit '/'
    click_on "Sign In"
    expect(current_path).to eq(login_path)
    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password
    click_on 'Log In'

    visit '/dashboard'
    
    click_on 'Send an Invite'
    

    expect(current_path).to eq('/invite')
    save_and_open_page
    expect(page).to have_content('Please submit users GitHub handle.')

    fill_in "GitHub Handle:", with: @user_2.login
    click_on 'Send Invite'
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Successfully sent invite!"')

  end
end