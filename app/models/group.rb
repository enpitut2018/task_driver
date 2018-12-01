class Group < ApplicationRecord
    validates :name, presence: true
    belongs_to :user
    has_many :tasks, dependent: :delete_all
end