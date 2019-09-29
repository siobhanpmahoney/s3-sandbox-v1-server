class CreateVersions < ActiveRecord::Migration[6.0]
  def change
    create_table :versions do |t|
      t.string :date
      t.text :description
      t.string :s3_key, unique: true
      t.string :etag, unique: true, null: false
      t.references :song, null: false, foreign_key: true

      t.timestamps
    end
  end
end
