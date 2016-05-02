class Meal < ActiveRecord::Base
  belongs_to :guests
  belongs_to :invitees
end
