module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil? # Retorna el negado de si current_user es nil
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user=(user) # Equivale a current_user=(...)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) # El ||= indica que lo asigna si el current_user es nil
  end
end
