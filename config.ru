require 'rubygems'
require File.join(File.dirname(__FILE__), './app/bookmarkmanager_web.rb')

run Sinatra::Application
run BookMarkManagerWeb