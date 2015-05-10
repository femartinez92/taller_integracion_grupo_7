class Api::V1::B2bController < ApplicationController
	protect_from_forgery with: :null_session
	before_action :authorize, except:[:create_group, :documentation]
	def create_group
		@group = Group.new(group_params)

		respond_to do |format|
			if @group.save
				format.json {render json: @group.api_key}
			else
				format.json {render json: @group.errors}
			end
		end
	end

	 def documentation
	 	respond_to do |format|
	 		format.html
	 		format.json {render json: 'probando123'}
	end

	end
	def group_params
		params.permit(:username, :password)
	end
	def token
		@token = params[:access_token]
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
