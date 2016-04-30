class Meal < ActiveRecord::Base
  has_many :guests
  has_many :invitees
end
