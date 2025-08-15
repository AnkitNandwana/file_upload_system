class CreateSharedLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :shared_links do |t|
      t.references :file_record, null: false, foreign_key: true
      t.string :slug
      t.datetime :expires_at

      t.timestamps
    end
  end
end
