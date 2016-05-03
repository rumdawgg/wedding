class Invitee < ActiveRecord::Base
  has_one :meal
  has_many :guests
  accepts_nested_attributes_for :guests, :allow_destroy => true
end
