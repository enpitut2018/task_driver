json.extract! task, :id, :name, :deadline, :importance, :note, :status, :start_time, :finish_time, :created_at, :updated_at
json.url task_url(task, format: :json)
