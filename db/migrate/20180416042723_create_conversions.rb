class CreateConversions < ActiveRecord::Migration[5.1]
  def change
    create_table :conversions do |t|
      t.string :voice
      t.string :text
      t.string :aws_location
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
