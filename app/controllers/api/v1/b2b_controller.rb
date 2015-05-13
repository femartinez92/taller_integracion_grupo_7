class Api::V1::B2bController < ApplicationController
	protect_from_forgery with: :null_session
	before_filter :authorize, except:[:create_group, :documentation, :get_token]
	before_action :group_params, only: [:create_group, :get_token]
	before_action :order_params, only: [:create_order, :accepted_order, :rejected_order, :canceled_order]

	# Este método recibe los parametros username y password para crear un usuario de grupo
	# Si el grupo es creado satisfactoriamente, se devuelve el token.
	# Errores: 
	#  - Falta el usuario o la contraseña
	#  - EL nombre de grupo ya existe
	def create_group
		@group = Group.new(@params)
		respond_to do |format|
			if @group.save
				format.json {render json: {token: @group.api_key.access_token},status:200}
			else
				if @group.errors.messages[:username] || @group.errors.messages[:password]
					 if @group.errors.messages[:username] == '["Missing parameters"]' || @group.errors.messages[:password]
					 	format.json {render json: {description: 'Missing parameters'},status:400}
					 else
					 	format.json {render json: {description: 'Group already exists'},status:409}
					 end
				else
					format.json {render json: {description: @group.errors}, status:500 }
				end
			end
		end
	end
	
	# Este método recibe el usuario y contraseña de un grupo y devuelve el token asociado al grupo
	def get_token
		respond_to do |format|
			if @params[:username] && @params[:password]
				@group = Group.where(username: @params[:username]).first
				if @group
					if @group.verify_password(@params[:password])
						format.json {render json: {token: @group.api_key.access_token},status:200}
					else
						format.json {render json: {description: 'Invalid password'},status:404}
					end
				else
					format.json {render json: {description: 'Group not found'},status:404}
				end
			else
				format.json {render json: {description: 'Missing parameters'},status:400}
			end
		end
	end

	# Métodos orden de compra
	# Antes de todos estos métodos se valida el token y se setea la variable @order con el id

	#Este método avisa que se generó una orden de compra
	def create_order
		respond_to do |format|
			format.json {render json: {},status:200}
		end
	end
	#Este método avisa que una orden de compra fue aceptada
	def accepted_order
		respond_to do |format|
			format.json {render json: {},status:200}
		end
	end

	#Este método avisa que una orden de compra fue rechazada
	def rejected_order
		respond_to do |format|
			format.json {render json: {},status:200}
		end
	end

	#este método avisa que una orden de compra fue cancelada
	def canceled_order
		respond_to do |format|
			format.json {render json: {},status:200}
		end
	end

	# Métodos facturas
	# Antes de todos los métodos de facturas (invoice) se setea la variable @invoice con el
	# id de la factura entregado en el request y se verifica el token

	# Este método avisa que se genero una factura
	def issued_invoice
		respond_to do |format|
			format.json {render json: {},status:200}
		end
	end
	# Este método avisa que una factura se pago
	def invoice_paid
		respond_to do |format|
			format.json {render json: {},status:200}
		end
	end
	# Este método avisa que una factura fue rechazada
	def rejected_invoice
		respond_to do |format|
			format.json {render json: {},status:200}
		end
	end

	#Este metodo es para la página estática de la documentación
	def documentation
	end

	private
	def invoice_params
		@invoice = params.permit(:invoice_id)
	end
	def order_params
		@order = params.permit(:order_id)
	end
	def group_params
		#En caso de que vengan en el header bajo estos parametros
		username = request.headers.env["HTTP_USERNAME"]
		password = request.headers.env["HTTP_PASSWORD"]
		@params = params.permit(:username, :password)
		if username
			@params[:username] = username
		end
		if password
			@params[:password] = password			
		end
	end
	def token
		@token = request.headers[:authorization]
	end

	#Este metodo ve si el token provisto es valido, aún no esta probado
	def authorize
		token #Seteamos la variable @token
		if ApiKey.where(access_token: @token).first
			return true
		else
			p 'token invalido'
			respond_to do |format|
				format.json {render json: {description: 'Invalid token'},status: :unauthorized}
			end
		end
	end
end
