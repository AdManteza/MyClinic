class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
      t.string   :name
      t.string   :domain
      t.datetime :date

      t.timestamps
    end
  end
end
