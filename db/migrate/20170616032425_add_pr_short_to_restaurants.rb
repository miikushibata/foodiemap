class AddPrShortToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :pr_short, :string
  end
end
