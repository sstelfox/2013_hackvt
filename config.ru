
base_directory = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(base_directory) unless $LOAD_PATH.include?(base_directory)

require 'bike_reports.rb'

# Workaround for the annoyting thin bug that prevents it from closing on a Ctrl-C
trap('INT') { exit }

run BikeReports::App

