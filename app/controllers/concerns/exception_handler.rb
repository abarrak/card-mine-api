module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { status: 404, message: e.message }, status: :not_found
    end

    # TODO: resue from all in production
  end
end
