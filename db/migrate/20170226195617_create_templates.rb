class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.string :name, index: true
      t.string :image
      t.text :description

      t.timestamps
    end
  end
end
