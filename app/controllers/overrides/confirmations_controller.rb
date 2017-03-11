module Overrides
  class ConfirmationsController < DeviseTokenAuth::ConfirmationsController
    def show
      @resource = resource_class.confirm_by_token(params[:confirmation_token])

      if @resource && @resource.id
        @resource.confirm
        @resource.save!

        yield @resource if block_given?

        redirect_to(params[:redirect_url])
      else
        raise ActionController::RoutingError.new('Not Found')
      end
    end
  end
end
