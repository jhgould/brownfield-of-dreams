require 'rails_helper'

describe 'Email invitations' do

  before :each do
    @user = create(:user, token: ENV["GH_API_KEY"])
    @user_2 = create(:user, token: ENV["2_GH_API_KEY"], login: "jhgould")
  end

  it "user can send invite" do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/dashboard'
    
    click_on 'Send an Invite'
    expect(current_path).to eq('/invite')
    
    expect(page).to have_content('Please submit users GitHub handle.')
    
    fill_in "Github handle", with: 'madhalle'
    click_on 'Send Invite'
    
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Successfully sent invite!')

  end
end