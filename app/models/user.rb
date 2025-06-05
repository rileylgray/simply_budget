class User < ApplicationRecord
  has_secure_password

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  has_many :expenses, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :income_categories, dependent: :destroy
  has_many :expense_categories, dependent: :destroy
  has_many :budgets, dependent: :destroy

  before_create :generate_confirmation_token


  def name
    "#{firstname} #{lastname}"
  end

  def confirmed?
    confirmed_at.present?
  end

  def confirm!
    update(confirmed_at: Time.current, confirmation_token: nil)
  end

  private

  def password_required?
    new_record? || password.present?
  end

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64(32)
  end
end
