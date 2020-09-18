class Students < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.integer :house_id
      t.boolean :admin, default: false
      t.string :password_digest
      t.timestamps null: false
    end
  end
end
