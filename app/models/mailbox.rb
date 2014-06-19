class Mailbox < ActiveRecord::Base
  before_create :encrypt_password
  before_update :change_password, if: Proc.new { !self.old_password.empty? }
  before_save :set_fields
  after_create :create_alias
  after_update :update_alias

  self.table_name = "mailbox"
  establish_connection "#{Rails.env}_postfix".to_sym

  belongs_to :domain, class_name: 'PostfixDomain', foreign_key: 'domain'
  has_many :aliases, class_name: 'Alias', foreign_key: 'goto', dependent: :delete_all

  attr_accessor :old_password, :password1, :password1_confirmation

  validate :check_old_password, on: :update, if: Proc.new { !self.password1.empty? }
  validates :password1, :password1_confirmation, presence: true, on: :create
  validates :password1, :password1_confirmation, presence: true, on: :update, if: Proc.new { !self.old_password.empty? }
  validates :password1, confirmation: true

  private

  def change_password
    self.password = self.password1.crypt("$1$#{SecureRandom.hex[0,22]}$")
  end

  def check_old_password
    errors[:old_password] << "Contraseña incorrecta" if extract_password_from_crypt(self.password) != extract_password_from_crypt(self.old_password.crypt("$1$#{extract_salt_from_crypt(self.password)}$"))
  end

  def encrypt_password
    self.password = self.password1.crypt("$1$#{SecureRandom.hex[0,22]}$")
  end

  def set_fields
    self.modified = Time.now
    self.maildir = "#{self.domain}/#{self.username.split('@').first}/"
    self.local_part = "#{self.username.split('@').first}"
  end

  def create_alias
    Alias.create address: self.username, goto: self.username, domain: self.domain, created: Time.now, modified: Time.now, active: 1
  end

  def update_alias
    self.aliases.first.update_attribute(:modified, Time.now)
  end

  def extract_salt_from_crypt(crypted_password)
    crypted_password.split('$')[2]
  end

  def extract_password_from_crypt(crypted_password)
    crypted_password.split('$').last
  end
end
