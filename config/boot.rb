require 'stealth'
require 'dotenv/load'
require_relative './environment'

Bundler.require(:default, Stealth.env)

Stealth.boot
