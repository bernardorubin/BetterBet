class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # has_many :portfolios, through: :user_portfolios, source: :portfolio
# dependent destroy?
   def display_name
     first_name.present? ? "#{first_name} #{last_name}" : email
  end
end
