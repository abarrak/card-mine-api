class Rack::Attack
  # If you don't want to use Rails.cache (Rack::Attack's default), then configure it here.
  #
  # Note: The store is only used for throttling (not blacklisting and  whitelisting).
  # It must implement .increment and .write like ActiveSupport::Cache::Store
  # Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  ## Throttle Spammy Clients
  throttle('req/ip', :limit => 8, :period => 1.second) do |req|
    req.ip
  end
end
