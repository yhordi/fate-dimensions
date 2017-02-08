class User < ActiveRecord::Base
  has_secure_password
  validates :name, uniqueness: true, presence: true
  has_many :systems, dependent: :destroy
  has_many :adventures, foreign_key: 'game_master_id'
end
