class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites
  
  #自分をお気に入りしている user_id 達を取得
  #「中間モデルを経由する」設定を追加して User モデルと一対多の関係であることを指定
  has_many :favoriting, through: :favorites, source: :user_id
  has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'user_id'
  has_many :favoriting, through: :reverses_of_favorite, source: :user 

  
end
