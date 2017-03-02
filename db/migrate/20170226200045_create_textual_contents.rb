class CreateTextualContents < ActiveRecord::Migration[5.0]
  def change
    create_table :textual_contents do |t|
      t.text :content
      t.integer :x_position
      t.integer :y_positin
      t.string :font_family
      t.string :font_size
      t.string :color
      t.references :card, foreign_key: true, index: true

      t.timestamps
    end
  end
end
