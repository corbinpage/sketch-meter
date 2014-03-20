class User < ActiveRecord::Base
  has_many :authentications
  has_many :scans
  has_one :twitter_detail
  validates :email, uniqueness: true
  validates :email, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #, :validatable
end
