require 'rubygems'
require "log4r"
include Log4r
       $mylog = Logger.new 'mylog'
       $mylog.outputters = Outputter.stdout
       $file = FileOutputter.new(
        'fileOutputter', :filename => 'D:\EBI\MyProjects\Razoo\Automation\Selenium\Selenium2\ModularFramework\Log\MyLogfile.csv',:trunc => false)
       $format = PatternFormatter.new( :pattern => "[%l] %d :: %m")

       $file.formatter = $format
       # log level order is DEBUG < INFO < WARN < ERROR < FATAL
       $mylog.level = Log4r::INFO
       $mylog.add($file)