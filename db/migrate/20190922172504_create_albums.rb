class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :title, unique: true, null: false
      t.string :etag, unique: true
      t.string :s3_key, unique: true

      t.timestamps
    end
  end
end
