class Api::V1::B2bController < ApplicationController
	protect_from_forgery with: :null_session
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

	end
	def group_params
		params.permit(:username, :password)
	end
end
