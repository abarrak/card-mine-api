class AddWidthAndHeightToTextualContent < ActiveRecord::Migration[5.0]
  def change
    add_column :textual_contents, :width, :integer
    add_column :textual_contents, :height, :integer
  end
end
