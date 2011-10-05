# -*- coding: utf-8 -*-

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/../../lib"

require 'dcmgr/rubygems'
require 'dcmgr'

Dcmgr.configure(File.expand_path('../../../config/dcmgr.conf', __FILE__))

use Dcmgr::Rack::RunInitializer, lambda {
  Dcmgr.run_initializers
}, lambda {
  next if Isono::NodeModules::DataStore.disconnected? == false
  Dcmgr.run_initializers('sequel')
}

run Dcmgr::Adapters::EC2ToWakame.new
