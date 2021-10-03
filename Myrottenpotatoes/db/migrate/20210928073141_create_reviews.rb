class CreateReviews < ActiveRecord::Migration[6.1]
  def up
    create_table :reviews do |t|
      t.integer    'potatoes'
      t.text       'comments'
      t.references 'moviegoer'
      t.references 'movie'
      t.timestamps
    end
  end
  def down ; drop_table :reviews; end
end
