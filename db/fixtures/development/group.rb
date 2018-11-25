require 'csv'

csv = CSV.read('db/fixtures/development/group.csv')
csv.each do |group|
	Group.seed(:id) do |s|
		s.id = group[0]
		s.parent_id = group[1]
		s.name = group[2]
		s.user_id = group[3]
		s.importance = group[4]
		s.visible = group[5]
	end
end