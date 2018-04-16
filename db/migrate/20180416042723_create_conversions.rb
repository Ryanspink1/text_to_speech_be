class CreateConversions < ActiveRecord::Migration[5.1]
  def change
    create_table :conversions do |t|
      t.string :original_text
      t.text :synthesized_mime
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
