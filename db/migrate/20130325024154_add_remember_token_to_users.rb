class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_token, :string # Columna para recordar la session
    add_index  :users, :remember_token # Indice de busqueda, unique
  end
end
