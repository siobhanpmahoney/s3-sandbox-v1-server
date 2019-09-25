class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :title, null: false, unique: true
      t.references :album, foreign_key: true

      t.timestamps
    end
  end
end
