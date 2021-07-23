#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path
#:production, :test

#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path
configure :production, :development do db = URI.parse(ENV['DATABASE_URL'] || 'postgres://adminruby:Ruby.2024@localhost:5432/app_myruby')
#db = URI.parse(ENV['DATABASE_URL'] || 'postgres://192.168.0.6:5432/app_myruby')
	ActiveRecord::Base.establish_connection(
			:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
			:host     => db.host,
			:username => db.user,
			:password => db.password,
			:database => db.path[1..-1],
			:encoding => 'utf8'
	)
end

