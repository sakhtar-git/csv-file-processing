#!/usr/local/bin/ruby

=begin
	1) A ruby script to process csv file based on the following requirement:
		Given this file please write a script that produces json formatted output that 
		identifies the highest average paying job title along with the department for all unique first names. 
		Please ignore Sr and roman numerals (like II, III).

	2) Requirements
		gem install smarter_csv -v 1.1.4

	3) Basic Configuration
		Ruby installed
		$ ruby -version
			ruby 2.3.7

	4) Running the script
		$ ruby csv_processor.rb
		OR $ ruby csv_processor.rb >> result.csv
			result.csv has the output in json
=end

require 'smarter_csv'
require 'json'

csv_emp_arrays = SmarterCSV.process('City_of_Seattle_Wage_Data.csv')
names_group_array = csv_emp_arrays.group_by { |h| [h[:first_name],h[:department]] }	
names_group_array.each do |k,v|
	job_hash = {}
	v.each do |x|
		title = x[:job_title].gsub(/Jr|Sr|I/,'').strip
		hourly_rate = x[:hourly_rate]
		emp_count = 1
		if job_hash["#{title}"]
			job_hash["#{title}"][:total_sal] += hourly_rate 
			job_hash["#{title}"][:emp_count] +=1
			job_hash["#{title}"][:avg] = (job_hash["#{title}"][:total_sal]/job_hash["#{title}"][:emp_count]).to_f
		else
			job_hash["#{title}"] =  {:total_sal=> hourly_rate, :emp_count => 1, :avg =>  hourly_rate}
		end
	end

	high_sal_hash = job_hash.max_by{|(k,v)| v[:avg]} || {}
	first_name  = k[0]
	dept    	= k[1]
	job 		= high_sal_hash[0]
	rate 		= high_sal_hash[1][:avg]

	final_hash = { "#{first_name}" => { "Department" => "#{dept}",
	"Job Title" => "#{job}",
	"Average Hourly Rate" => "#{rate}"
		}}
	puts JSON.pretty_generate(final_hash).gsub("=>", ":")
end
#----end of the script---------