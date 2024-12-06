class Meeting < ApplicationRecord
  # Relations
  belongs_to :industrial, class_name: 'User'
  belongs_to :project_manager, class_name: 'User'

  # Enums
  enum :status, {
    pending: 0,
    accepted: 1,
    rejected: 2,
    completed: 3,
    cancelled: 4
  }

  enum :meeting_type, {
    initial: 0,
    followup: 1,
    presentation: 2
  }

  # Validations
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :status, presence: true
  validates :meeting_type, presence: true
  validate :end_time_after_start_time
  validate :no_meeting_overlap

  # Scopes
  scope :upcoming, -> { where('start_time > ?', Time.current).order(start_time: :asc) }
  scope :past, -> { where('end_time < ?', Time.current).order(start_time: :desc) }
  scope :today, -> { where(start_time: Time.current.beginning_of_day..Time.current.end_of_day) }

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def no_meeting_overlap
    return if start_time.blank? || end_time.blank?

    overlapping_meetings = Meeting.where(
      "(start_time, end_time) OVERLAPS (?, ?)",
      start_time, end_time
    ).where.not(id: id)

    if overlapping_meetings.exists?
      errors.add(:base, "Meeting time conflicts with another meeting")
    end
  end
end
