class Record < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  establish_connection "#{Rails.env}_dns".to_sym
  belongs_to :zone, class_name: 'DnsDomain', foreign_key: 'domain_id'

  RECORD_TYPES = %w(A AAAA CNAME HINFO MX NAPTR NS PTR SOA SPF SRV SSHFP TXT RP)
end
