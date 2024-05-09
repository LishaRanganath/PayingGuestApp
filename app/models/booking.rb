class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :available_room
  belongs_to :duration

  after_save :notify_owner_of_complaint


  # private

  def notify_owner_of_complaint
    if complaints.present?
      owner = pg_building.owner
      owner.notifications.create(action: 'New Complaint', params: { booking_id: id })
    end
  end
end
