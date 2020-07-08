class Video < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.tutorials(current_user_id)
    select('videos.*, tutorials.*').joins(:user_videos, :tutorial).where("user_id = ?", current_user_id).uniq
  end

end
