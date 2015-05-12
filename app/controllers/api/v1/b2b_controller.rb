class Api::V1::B2bController < ApplicationController
	protect_from_forgery with: :null_session
	before_action :authorize, except:[:create_group, :documentation]
	def create_group
		@group = Group.new(group_params)

		respond_to do |format|
			if @group.save
				format.json {render json: {status: '200',token: @group.api_key.access_token}}
			else
				format.json {render json: @group.errors}
			end
		end
	end

	def documentation
	end

	def group_params
		params.permit(:username, :password)
	end

	private

	def token
		@token = request.headers[:authorization]
	end
	
	def authorize
		token
		if ApiKey.where(access_token: @token)
			return true
		else
			return false
		end
	end
end
