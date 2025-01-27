class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  has_many :invitations, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
