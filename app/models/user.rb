class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
                format: {with: VALID_EMAIL_REGEX},
                uniqueness: {case_sensitive: false}

  # railsのメソッドでパスワード実装がほぼ完了
  # モデル内にpassword_digestという属性が含まれていれば使える
  has_secure_password
  # セキュアにハッシュ化したパスワードを、データベース内のpassword_digestという属性に保存できるようになる。
  # 2つのペアの仮想的な属性 (passwordとpassword_confirmation) が使えるようになる。また、存在性と値が一致するかどうかのバリデーションも追加される18 。
  # authenticateメソッドが使えるようになる (引数の文字列がパスワードと一致するとUserオブジェクトを、間違っているとfalseを返すメソッド) 。
  validates :password, presence: true, length: { minimum: 6 }

  # 渡された文字列のハッシュ値を返すクラスメソッド
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
