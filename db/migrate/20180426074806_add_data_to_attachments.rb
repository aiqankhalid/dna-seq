class AddDataToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :data, :text
  end
end
