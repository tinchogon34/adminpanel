class PostfixDomain < ActiveRecord::Base
  self.table_name = "domain"
  establish_connection "#{Rails.env}_postfix".to_sym

  has_many :mailboxes, foreign_key: 'domain', dependent: :destroy

  def to_s
    self.domain
  end
end
