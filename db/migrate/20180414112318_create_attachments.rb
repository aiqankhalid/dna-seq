class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.text :sequence
      t.integer :type_id

      t.timestamps
    end
  end
end
