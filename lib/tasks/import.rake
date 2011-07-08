require 'rubygems'
require 'faster_csv'

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
end