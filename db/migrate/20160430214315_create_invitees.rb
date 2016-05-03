class CreateInvitees < ActiveRecord::Migration
  def change
    create_table :invitees do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :is_attending
      t.string :remarks
      t.references :meal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
