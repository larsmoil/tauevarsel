# == Schema Information
#
# Table name: street_events
#
#  id          :integer         not null, primary key
#  street      :string(255)
#  stretch     :string(255)
#  date        :date
#  time_of_day :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class StreetEvent < ActiveRecord::Base
  validates :street, presence: true
  validates :stretch, presence: true
  validates :date, presence: true
  validates :time_of_day, presence: true
end
