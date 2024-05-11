class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :available_room
  belongs_to :duration


  # private
  def has_complaint?
    !complaints.blank? # Assuming complaints is the attribute where you store the complaint
  end
 
end
