require 'rubygems'
require 'faster_csv'
require 'open-uri'
require 'net/http'

namespace :leadgeneration do
	task :import_departments => :environment do
	  Department.all.each{|d| d.delete}
		FasterCSV.foreach("#{Rails.root.to_s}/lib/tasks/province.csv", :col_sep => ";" ) {|row|
		    name = row[10]
		    code = row[8].to_i
		    puts "#{code} - #{name}"
		    if !name.blank? && !code.blank?
	        Department.create(:name => name, :code => code)
        end
		}
		
	end
	
	task :import_cities => :environment do
	  City.all.each{|d| d.delete}
		FasterCSV.foreach("#{Rails.root.to_s}/lib/tasks/comuni.csv", :col_sep => ";" ) {|row|
		    name = row[8]
		    department_id = row[1].to_i
		    puts "#{department_id} - #{name}"
		    if !name.blank? && !department_id.blank?
		      d = Department.where(:code => department_id)
		      if d.blank?
		        puts "#{name} without department!"
	        else
	          City.create(:name => name, :department_id => d.first.id)
          end
	      end
		}
		
	end
	
	task :geocode => :environment do
	  Company.find(:all).each do |c|
	    if c.latitude.blank? and c.longitude.blank?
        geo=c.geocode
        unless geo.blank?
          c.update_attribute(:latitude, geo[0])
          c.update_attribute(:longitude, geo[1])
        end
      end
    end
  end
  
  task :checkxml => :environment do
    uri_error = []
    doc = Hpricot(open("http://localhost:3000/sitemap.xml"))
    doc.search("loc").each do |loc|
      puts "#{loc.inner_text}"
      uri_error << loc.inner_text if Net::HTTP.get_response(URI.parse(loc.inner_text)).blank?
    end
    puts "\n broken url #{uri_error.size}\n"
    uri_error.each do |broken|
      puts "\n broken url: #{broken} \n"
    end
  end
end