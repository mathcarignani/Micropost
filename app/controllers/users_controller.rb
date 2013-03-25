class UsersController < ApplicationController
  def new
    @user = User.new # Creo el nuevo usuario, el que se va a utilizar en la vista para cargarle los datos
  end

  def show
    @user = User.find(params[:id]) # Busco el usuario que tiene el id recibido por parametro
  end

  # Metodo para crear el usuario ,al aceptar el formulario se llama.
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Micropost!" # Mensaje a mostrar de bienvenida
      redirect_to @user # Redirecciona a la visualizacion del usuario creado
    else
      render 'new'
    end
  end
end
