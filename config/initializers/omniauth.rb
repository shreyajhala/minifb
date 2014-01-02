OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '605590942821675', 'ad48ea89c8909f7bbeb0104d3c76f94e'
end