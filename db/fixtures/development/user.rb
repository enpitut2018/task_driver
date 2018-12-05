require 'csv'

csv = CSV.read('db/fixtures/development/user.csv')
csv.each do |user|
	user = User.new(:email => user[0], :username => user[1], :password => user[2], :password_confirmation => user[3])
	user.skip_confirmation!
	user.save
end