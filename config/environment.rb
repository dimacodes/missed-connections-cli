# First Load Bundler
require 'bundler'
# Require the Gems from the Gemfile using Bundler
Bundler.require #=> This require's all gems in Gemfile

# Load Libraries
require_all './lib/missed-connections' # automatically requires files in proper order
