class CreateRider < ActiveRecord::Migration
  def up
    create_table :appusers do |t|

      
    end
  end
 
  def down
    drop_table :apprider
  end
end
