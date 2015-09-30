class CreateSectionEdits < ActiveRecord::Migration
  def change
    create_table :section_edits do |t|
    	t.references :admin_user # same has t.integer :admin_user_id
    	t.references :section
    	t.string :summary
      t.timestamps null: false
    end
    add_index :section_edits, [:admin_user_id, :section_id]
  end

end
