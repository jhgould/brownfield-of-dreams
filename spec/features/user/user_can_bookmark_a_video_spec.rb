require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)
    # expect {
      click_on 'Bookmark'
    # }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once" do
    tutorial= create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit tutorial_path(tutorial)
    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    visit tutorial_path(tutorial)
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end

  it "bookmarked videos show up on user dashboard" do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    tutorial2= create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    video2 = create(:video, title: "The bow tie", tutorial: tutorial2)
    user = User.create!(email: 'user@example.com', first_name: 'User', last_name: 'Regular', password:  "password")
    user2 = User.create!(email: 'user2@example.com', first_name: 'User2', last_name: 'Regular', password:  "password")
    # UserVideo.create!(user_id: user.id, video_id: video.id)
    visit "/"
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log In"

    visit tutorial_path(tutorial)
    # save_and_open_page
    click_on 'Bookmark'
    expect(current_path).to eq("/dashboard")
    # save_and_open_page
    expect(page).to have_content(video.title)
    expect(page).to_not have_content(video2.title)
    click_on "Log Out"

    visit "/"
    click_on "Sign In"
    fill_in "Email", with: user2.email
    fill_in "Password", with: user2.password
    click_on "Log In"

    visit "/dashboard"
    expect(page).to_not have_content(video.title)
    expect(page).to_not have_content(video2.title)

    visit tutorial_path(tutorial2)
    # save_and_open_page
    click_on 'Bookmark'
    expect(current_path).to eq("/dashboard")
    expect(page).to_not have_content(video.title)
    expect(page).to have_content(video2.title)
  end
end
