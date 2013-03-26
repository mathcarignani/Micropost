class UsersController < ApplicationController
  # Chequemos que haya un usuario conectado
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy] 
  # Before filter, ejecuta esto antes de hacer cualquier cosa, como
  # solo lo queremos para edit y update le indicamos, sino lo hace para todos
  # y ahora agregamos que para ver todos los usuarios tambien
  
  # Chequeamos que a su vez sea el mismo usuario que quiere modificar
  before_filter :correct_user, only: [:edit, :update]

  # Antes de eliminar chequeo que el usuario sea administrador
  before_filter :admin_user, only: [:destroy]

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

  # Metodo para ver todos los usuarios!
  def index
    @users = User.paginate(page: params[:page]) # Obtengo todos los usuario, y utilizo el paginate para paginarlos,
    # la pagina que vamos a paginar es la recibida por parametro, si es nil trae la primera
  end

  def destroy
    User.find(params[:id]).destroy # Busco el usuario y lo elimino
    flash[:success] = "User destroyed."
    redirect_to users_url # Redirijo a la lista de usuario
  end

  # METODOS PRIVADOS
  private

    def signed_in_user
      store_location # Guardo la url a la que quise ingresar para luego redirigir
      redirect_to signin_url, notice: "Please sign in." unless signed_in? # Redirijo, a menos que haya usuario logueado
      # Es lo mismo que si hacemos flash[:notice] = "..." y luego el redirect
    end

    def correct_user
      @user = User.find(params[:id]) # Busco el usuario del parametro
      redirect_to(root_path) unless current_user?(@user) # current_user? lo definimos en el session_helper
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin? # Si el usuario no es admin, lo redirijo al inicio
    end
end

# El new se utiliza para mostrar la pagina de nuevo, y al aceptar se utiliza el 
# create, lo mismo pasa con el edit y el update