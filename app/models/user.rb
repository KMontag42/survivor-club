# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#  role                   :string(255)
#  show_spoilers          :boolean          default(FALSE)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :contestants_users, class_name: "ContestantsUsers"
  has_many :contestants, through: :contestants_users

  has_many :picks

  def name
    name = "#{first_name} #{last_name}"
    name == " " ? email : name
  end

  def admin?
    role == 'admin'
  end

  def cash_picks(draft_id = nil)
    if draft_id
      picks.where(draft_id: draft_id, pick_type: 'cash')
    else
      picks.where(pick_type: 'cash')
    end
  end

  def drinking_picks(draft_id = nil)
    if draft_id
      picks.where(draft_id: draft_id, pick_type: 'drinking')
    else
      picks.where(pick_type: 'drinking')
    end
  end

end
