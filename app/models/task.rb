class Task < ApplicationRecord
  validates :description, presence: true
  validates :done, inclusion: { in: [true, false] }

  def current_status
    status
  end

  private

  def status
    return :done    if done?
    return :expired if due_date.past?
    :pending
  end
end
