require 'csv'

csv = CSV.read('db/fixtures/development/task.csv')
csv.each do |task|
	Task.seed(:id) do |s|
		s.id = task[0]
		s.name = task[1]
		s.importance = task[2]
		s.status = task[3].to_i
		s.group_id = task[4]
		s.deadline = DateTime.new(2019, 1, 1, 00, 00, 00)
		s.user_id = task[5]
	end
end