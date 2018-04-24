class CreateTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :types do |t|
      t.string :name
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
