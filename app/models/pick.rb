class Pick < ActiveRecord::Base
  belongs_to :draft
  belongs_to :user, as: :player
  belongs_to :contestant
  PICK_TYPE = %w(cash drinking)
end