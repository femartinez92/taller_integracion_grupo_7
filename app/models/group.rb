class Group < ActiveRecord::Base
	has_one :api_key, dependent: :destroy 
	after_create  :set_api_key

	private

	def set_api_key
		self.api_key = ApiKey.create()
	end
end
