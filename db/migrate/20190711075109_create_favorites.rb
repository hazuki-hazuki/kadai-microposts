class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true #データベース上でuser_id カラムとして存在し、そこに User の id が保存
      t.references :micropost, foreign_key: true #データベース上でmicropost_id カラムとして存在し、そこに Micropost の id が保存


      t.timestamps
      
      t.index [:user_id, :micropost_id], unique: true #ペアで重複するものが保存されないようにするデータベースの設定
    end
  end
end
