class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.string :content
      t.references :user, foreign_key: true #データベース上でuser_id カラムとして存在し、そこに User の id が保存

      t.timestamps
    end
  end
end
