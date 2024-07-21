class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    if resource.admin?
      rails_admin_path  # Redirect to Rails Admin dashboard
    else
      super
    end
  end
end
