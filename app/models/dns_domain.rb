class DnsDomain < ActiveRecord::Base
  after_create :create_zone, :create_soa_record  

  self.table_name = "domains"
  self.inheritance_column = :_type_disabled
  establish_connection "#{Rails.env}_dns".to_sym

  has_one :zone, foreign_key: 'domain_id', dependent: :delete
  has_many :records, foreign_key: 'domain_id', dependent: :delete_all
  
  validates :name, :type, presence: true
  validates :master, presence: true, if: Proc.new { type == 'SLAVE' }
  validates :name, uniqueness: true

  DNS_TYPES = %w(MASTER SLAVE NATIVE)

  def to_s
    self.name
  end

  private

  def create_zone
    Zone.create domain: self, owner: 1, zone_templ_id: 0
  end

  def create_soa_record
    Record.skip_callback(:save,:after,:update_soa_record)
    Record.create zone: self, name: self.name, type: "SOA", content: "ns1.#{self.name} hostmaster.#{self.name} #{Time.now.strftime('%Y%m%d')}00 1200 900 604800 3600", ttl: 0, prio: 0, change_date: Time.now.to_i
    Record.set_callback(:save,:after,:update_soa_record)
  end
end
