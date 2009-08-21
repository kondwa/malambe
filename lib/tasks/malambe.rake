namespace :malambe do
    def setup
      raise "Specify RAILS_ENV(production,development,or test)" unless RAILS_ENV
      @configs = ActiveRecord::Base.configurations[RAILS_ENV]
      @username = @configs["username"]
      @password = @configs["password"]
      @database = @configs["database"]
    end
    desc "Creates Database Schema From SQL"
    task :schema => [:environment] do 
      setup
      @schema = File.expand_path(RAILS_ROOT+"/db/schema.sql")
      raise "SQL Schema file #{@schema} does not exist" unless File.exist?(@schema)
      puts "Supply MySQL Root password on prompt:"
      @rtpass = STDIN.gets.chomp
      puts "Creating malambe database..."
      `mysql -u root --password=#{@rtpass} -e "CREATE DATABASE IF NOT EXISTS #{@database};"`
      puts "Loading sql schema file..."
      `mysql -u root --password=#{@rtpass} #{@database} < #{@schema}`
      puts "Creating malambe database user..."
      `mysql -u root --password=#{@rtpass} -e "GRANT ALL ON #{@database}.* TO #{@username}@localhost IDENTIFIED BY '#{@password}';"`
    end
end
