class UserVideo < ApplicationRecord
  belongs_to :video
  belongs_to :user

  def self.bookmarked(current_user_id)
    # select('videos.*').joins(:video).where("user_id = ?", current_user_id).pluck(:title)
    select('videos.*').joins(:video).where("user_id = ?", current_user_id)
  end

end
