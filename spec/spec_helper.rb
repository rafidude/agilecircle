require File.join(File.dirname(__FILE__), '../lib/', 'app.rb')

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'

set :environment, :test
