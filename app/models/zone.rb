class Zone < ActiveRecord::Base
  establish_connection "#{Rails.env}_dns".to_sym
  belongs_to :domain, class_name: 'DnsDomain', foreign_key: 'domain_id'

  validates :owner, :domain, :zone_templ_id, presence: true
end
