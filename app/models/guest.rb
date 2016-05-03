class Guest < ActiveRecord::Base
  belongs_to :invitee
  has_one :meal
  validates :first_name, :last_name, presence: true, length: { maximum: 30 }
end
