
class CreateAppuser < ActiveRecord::Migration[6.1]
  def change
   create_table :users do |t|
      t.string :name
      t.stirng :fname      
      t.stirng :email
      t.stirng :pass
      t.string :phone
      t.string :address
  end
end
