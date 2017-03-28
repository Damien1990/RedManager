class AddCountryIdToManagers < ActiveRecord::Migration[5.0]
  def change
    add_column :managers, :country_id, :integer
  end
end
