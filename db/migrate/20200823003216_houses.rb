class Houses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.string :name
      t.string :secret
      t.timestamps null: false
    end
  end
end
