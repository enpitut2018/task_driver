Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins Rails.application.config.x.cors_allowed_origins

    resource '/v1/*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]

    resource '/endpoints/*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end