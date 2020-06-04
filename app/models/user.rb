class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks, dependent: :destroy

  has_one_attached :photo

  scope :admin, -> { where(admin: true) }

  after_create :make_it_god



  private 

  def make_it_god
    unless User.limit(2).count > 1
      self.update(admin: true)
    end
  end

end
