# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation #Set y get de estos atributos
  # password y password_confirmation no son atributos de la tabla
  has_secure_password #Encrypta el password y lo guarda en password_digest
  # Para comprobar que la contrasena es correcta usamos:
  	# user.authenticate("Contrasena")

  before_save { |user| user.email = email.downcase } #Antes de guardar pase el mail a minusculas
  before_save :create_remember_token # Antes de salvar vamos a crear el token

  validates :name, presence: true, length: { maximum: 50 } #Valida que el name venga si o si, y que sea menor = a 50
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #Constante, expresion regular para validar mail (Letras mayusculas!)
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, #Valida que el email venga tambien.Y valida la expresion reg.
  					uniqueness: { case_sensitive: false } #A su vez chequea que sea unico y que no sea sensible a mayuscula
  
  validates :password, presence: true, length: { minimum: 6 } #Nos aseguramos que venga el password y tenga al menos 6 letras
  validates :password_confirmation, presence: true #Nos aseguramos que venga la confirmacion del password
  
  # @user.valid? para ver si un usuario es valido
  # @user.errors.full_messages para ver los mensajes de error de validacion
  # @user.authenticate("Contrasena") para ver si la contrasena es correcta

  private # Metodos privados

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64 # Crear un valor aleatorio seguro
    end
end
