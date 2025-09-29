class CreateSiteContents < ActiveRecord::Migration[8.0]
  def change
    create_table :site_contents do |t|
      t.string :key
      t.string :title
      t.text :content
      t.string :content_type

      t.timestamps
    end
  end
end
