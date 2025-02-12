class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden }
        format.html { redirect_to root_path, alert: "Você não possui permissão!" }
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :role, :password, :password_confirmation)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :role, :password, :password_confirmation, :current_password)}
    end
end
