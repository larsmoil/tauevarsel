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

  def to_s
    "#{street}, stretch: #{stretch}, date: #{date}, time_of_day: #{time_of_day}"
  end

  def self.search(search)
    if search
      where('date = ?', "#{search}")
    else
      scoped
    end
  end
end
