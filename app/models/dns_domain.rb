class DnsDomain < ActiveRecord::Base
  after_save :create_zone

  self.table_name = "domains"
  self.inheritance_column = :_type_disabled
  establish_connection "#{Rails.env}_dns".to_sym

  has_one :zone, foreign_key: 'domain_id', dependent: :destroy
  has_many :records, foreign_key: 'domain_id', dependent: :destroy
  
  validates :name, :type, presence: true
  validates :master, presence: true, if: Proc.new { type == 'SLAVE' }
  validates :name, uniqueness: true

  DNS_TYPES = %w(MASTER SLAVE)

  def to_s
    self.name
  end

  private

  def create_zone
    Zone.create domain: self, owner: 1, zone_templ_id: 0
  end

end
