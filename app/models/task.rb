class Task < ApplicationRecord
    validates :name, presence: true
    belongs_to :group
    enum status: { todo: 1, doing: 2, done: 3 }
end
