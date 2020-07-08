class UserVideo < ApplicationRecord
  belongs_to :video
  belongs_to :user

  def self.bookmarked(current_user_id)
    # select('videos.*').joins(:video).where("user_id = ?", current_user_id).pluck(:title)
    select('videos.*').joins(:video).where("user_id = ?", current_user_id)
    # Video.select('tutorials.*').joins(:tutorial)
    # Video.joins(:user_videos, :tutorial).where("user_id = ?", 1)
    # Video.select('videos.title, tutorials.title').joins(:user_videos, :tutorial).where("user_id = ?", 1)
  end

  # def self.tutorials(current_user_id)
  #   Video.select('videos.title, tutorials.title').joins(:user_videos, :tutorial).where("user_id = ?", current_user_id)
  # end

end
