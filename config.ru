
require './bike_reports'

# Workaround for the annoyting thin bug that prevents it from closing on a Ctrl-C
trap('INT') { exit }

run BikeReports::App

