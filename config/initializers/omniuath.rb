OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "708526605958005", "ffe365460774ab5ff41de8033d6ad00b"
end
