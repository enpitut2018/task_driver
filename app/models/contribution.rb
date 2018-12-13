class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :task

  enum finality: { final: true, not_final: false }
  enum status: { active: true, inactive: false }

  validates :status, uniqueness: { scope: [:user_id, :task_id], on: :create }
end
