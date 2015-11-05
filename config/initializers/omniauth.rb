OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "708526605958005", "d1a9f392aa836a74f2c9e8b1c0587308"
end
