class CreatePostSubs < ActiveRecord::Migration[5.1]
  def change
    create_table :post_subs do |t|
      t.integer :sub_id, NULL: false
      t.integer :post_id, NULL: false

      t.timestamps
    end
  end
end
