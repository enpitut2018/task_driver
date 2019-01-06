class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :task

  enum finality: { final: true, not_final: false }
  enum status: { active: true, inactive: false }

  validates :status, uniqueness: { scope: [:user_id, :task_id], if: 'active?' }

  scope :finished, -> { where.not(finished_at: nil) }
end