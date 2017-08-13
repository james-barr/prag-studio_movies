class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :total_gross
      t.text :description
      t.date :released_on

      t.timestamps
    end
  end
end
