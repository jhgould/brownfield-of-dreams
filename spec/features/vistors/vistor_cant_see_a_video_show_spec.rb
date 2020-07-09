require 'rails_helper'

describe 'visitor sees a video show' do
  it 'vistor clicks on a tutorial title from the home page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    
    expect(page).to_not have_content(video.title)
    expect(page).to_not have_content(tutorial.title)
  end
end
