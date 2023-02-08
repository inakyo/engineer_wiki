class CreateArticleHistory < ActiveRecord::Migration[7.0]
  def change
    create_table :article_histories do |t|
      t.integer :article_id, null: false
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :content
      t.integer :tag_ids, array: true
      t.timestamps
    end
  end
end
