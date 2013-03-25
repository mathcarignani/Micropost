class UsersController < ApplicationController
  def new
    @user = User.new # Creo el nuevo usuario, el que se va a utilizar en la vista para cargarle los datos
  end

  def edit
    @user = User.find(params[:id]) # Busco el usuario que tiene el id recibido por parametro
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

  # Metodo para actualizar la informacion del usuario en la base de datos
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # Handle a successful update.
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      # Si no se pudo actualizar el usuario
      render 'edit'
    end
  end

end

# El new se utiliza para mostrar la pagina de nuevo, y al aceptar se utiliza el 
# create, lo mismo pasa con el edit y el update