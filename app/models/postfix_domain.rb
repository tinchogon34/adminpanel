class PostfixDomain < ActiveRecord::Base
  self.table_name = "domain"
  establish_connection "#{Rails.env}_postfix".to_sym

  has_many :mail_boxes, class_name: 'Mailbox', foreign_key: 'domain', dependent: :delete_all

  validates :domain, presence: true, uniqueness: true
  validates :aliases, :mailboxes, presence: true, numericality: true

  def to_s
    self.domain
  end
end
