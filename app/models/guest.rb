class Guest < ActiveRecord::Base
  belongs_to :invitee
  has_one :meal
end
