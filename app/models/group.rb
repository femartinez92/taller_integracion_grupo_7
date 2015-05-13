class Group < ActiveRecord::Base
	has_one :api_key, dependent: :destroy 
	validates :username, :password, presence: true
	validates :username, uniqueness: true

	after_create  :set_api_key
	#Este método verifica si la contraasseña es correcta
	def verify_password(passwd)
		if self.password == passwd
			return true
		else
			return false
		end
	end


	private
	#Este metodo asigna una api_key a el grupo
	def set_api_key
		self.api_key = ApiKey.create()
	end
end
