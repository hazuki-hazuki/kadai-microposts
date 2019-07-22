class User < ApplicationRecord
    before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    has_many :microposts
    has_many :relationships
    has_many :favorites
    
    #自分がフォロー/お気に入りしている User・micropost達を取得
    has_many :favoritings, through: :favorites, source: :micropost
    has_many :followings, through: :relationships, source: :follow
   
    has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'micropost_id'
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    
    #自分をフォローしている（自分がフォローされている） User 達を取得
    #自分をお気に入りしている micropost_id 達を取得はいらない
    has_many :followers, through: :reverses_of_relationship, source: :user 
    
    
#フォローしようとしている other_user が自分自身ではないかを検証
#見つかれば relationshipのインスタンス（データの中身）を返し、見つからなければフォロー関係を保存(create = build + save)する
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

#relationship が存在すればフォローやめる
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

#フォローしている User 達を取得,other_user が含まれていないかを確認
#含まれている場合には、true,含まれていない場合には、false
  def following?(other_user)
    self.followings.include?(other_user)
  end

#following_ids は User モデルの has_many :followings, ... によって自動的に生成されるメソッド
#User がフォローしている User の id の配列を取得
#Micropost.where(user_id: フォローユーザ + 自分自身)
#モデル.where(条件)データベースから条件を指定し、条件に当てはまるレコードをすべて取得する
 def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
 end
 
 
 #以下お気に入り機能
 
#自分のお気に入りから見つかれば favoritesのインスタンス（データの中身）を返し、見つからなければお気に入り関係を保存(create = build + save)する
 def favorite(favorite_micropost)
    self.favorites.find_or_create_by(micropost_id: favorite_micropost.id)
 end
 
 
#favorite が存在すればお気に入りをやめる
 def unfavorite(favorite_micropost)
    favorite = self.favorites.find_by(micropost_id: favorite_micropost.id)
    favorite.destroy if favorite
 end

#お気に入りしている micropost:id達を取得,favoritingsが含まれていないかを確認
#含まれている場合には、true,含まれていない場合には、false
 def favoriting?(micropost)
    self.favoritings.include?(micropost)
 end
 
#ユーザが追加したお気に入りを一覧表示する
#favoriting_ids は User モデルの has_many :favoritings, ... によって自動的に生成されるメソッド
#User がフォローしている micropost の id の配列を取得
#Micropost.where(user_id: フォローユーザ + 自分自身)
#モデル.where(条件)データベースから条件を指定し、条件に当てはまるレコードをすべて取得する
 def favorite_microposts
    Micropost.where(micropost_id: self.favoriting_ids)
 end
  
 
 
end
