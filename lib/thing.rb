require 'drb/drb'
require 'yaml'
require_relative 'thing/tab'
require_relative 'thing/suite'
require_relative 'thing/ben_grimm'

URI = "druby://localhost:9797"

DRb.start_service(URI, Thing::BenGrimm.new)

DRb.thread.join