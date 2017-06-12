class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :code
      t.string :name
      t.string :adress
      t.string :image_url
      t.float :latitude
      t.float :longitude
      t.string :url

      t.timestamps
    end
  end
end
