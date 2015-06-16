class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :name
      t.text :content_entry
      t.string :user_id
      t.string :integer

      t.timestamps null: false
    end
  end
end
