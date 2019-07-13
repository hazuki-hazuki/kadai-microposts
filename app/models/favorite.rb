class Favorite < ApplicationRecord
  belongs_to :user #モデル名_id の名前になっている user_id はRailsの方で自動的にUserを参照する
  belongs_to :micropost #モデル名_id の名前になっている micropost_id はRailsの方で自動的にUserを参照する
end
