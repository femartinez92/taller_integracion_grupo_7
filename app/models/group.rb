class Group < ActiveRecord::Base
	has_one :api_key, dependent: :destroy 
end
