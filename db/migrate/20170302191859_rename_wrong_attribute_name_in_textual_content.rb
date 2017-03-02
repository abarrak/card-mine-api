class RenameWrongAttributeNameInTextualContent < ActiveRecord::Migration[5.0]
  def change
    change_table :textual_contents do |t|
      t.rename :y_positin, :y_position
    end
  end
end
