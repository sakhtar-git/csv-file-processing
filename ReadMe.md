
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
		OR
		$ ruby csv_processor.rb >> result.csv 
		# result.csv has the output in json