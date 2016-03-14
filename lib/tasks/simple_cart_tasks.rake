namespace :simple_cart do
  desc "Adding new delivery service to 'deliveries' table. Syntax: 'rake simple_cart:create_delivery [NAME] [COSTS]'"
  task :create_delivery => :environment do
    ARGV.each { |a| task a.to_sym do ; end }
    SimpleCart::Delivery.create(company: ARGV[1], costs: ARGV[2])
    puts "#{ARGV[1]} was successfully added."
  end

  task :delete_delivery => :environment do
    ARGV.each { |a| task a.to_sym do ; end }
    SimpleCart::Delivery.find_by(company: ARGV[1]).destroy
  end

  task :delete_all => :environment do
    SimpleCart::Delivery.delete_all
  end

end

