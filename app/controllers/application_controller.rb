# Application controller. Class methods can be used in any other controller class
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  private

  # Overwriting the sign_out redirect path method
  def after_sign_in_path_for(resource_or_scope)
    home_index_path
  end
end
