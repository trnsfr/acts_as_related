# Include hook code here
require 'acts_as_related'
ActiveResource::Base.send(:include, Trnsfr::Acts::Related)
ActiveRecord::Base.send(:include, Trnsfr::Acts::Related)
