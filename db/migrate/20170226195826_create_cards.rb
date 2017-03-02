class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :title
      t.text :description
      t.references :user, foreign_key: true, index: true
      t.references :template, foreign_key: true, index: true
      t.boolean :draft

      t.timestamps
    end

    add_index :cards, :title
  end
end
