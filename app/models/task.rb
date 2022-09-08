class Task < ApplicationRecord
  validates :description, presence: true
  validates :done, inclusion: { in: [true, false] }

  belongs_to :parent,    class_name: 'Task', optional: true
  has_many   :sub_tasks, class_name: 'Task',
             foreign_key: :parent_id, dependent: :destroy

  scope :only_parents, -> { where(parent_id: nil) }

  def is_parent?
    !!parent.nil?
  end

  def is_subtask?
    !is_parent?
  end

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
