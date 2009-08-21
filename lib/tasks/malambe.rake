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

      `mysqladmin create #{@database} -u root --password=#{@rtpass}`
      `mysql -u root --password=#{@rtpass} #{@database} < #{@schema}`
      `mysql -u root --password=#{@rtpass}-e "GRANT ALL ON #{@database}.* TO #{@username}@localhost" IDENTIFIED BY '#{@password}';`

      Rake::Task["db:schema:dump"].invoke
    end
end
