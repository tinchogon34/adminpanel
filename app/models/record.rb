class Record < ActiveRecord::Base
  after_destroy :update_soa_record
  after_save :update_soa_record

  self.inheritance_column = :_type_disabled
  establish_connection "#{Rails.env}_dns".to_sym
  belongs_to :zone, class_name: 'DnsDomain', foreign_key: 'domain_id'

  validates :zone, :name, :content, :type, :ttl, :prio, presence: true

  RECORD_TYPES = %w(A AAAA CNAME HINFO MX NAPTR NS PTR SOA SPF SRV SSHFP TXT RP)

  private

  def update_soa_record
    soa = self.zone.records.find_by(type: "SOA")
    content = soa.content.split(" ")
    serial = content[2]
    date = serial[0..7]
    number = serial[8..-1]
    new_serial = "#{Date.today.strftime('%Y%m%d')}00"

    
    if date == Date.today.strftime("%Y%m%d")
      number_int = number.to_i
      number_int += 1
      number_str = number_int.to_s
         
      until number_str.length == number.length do
        number_str = "0" + number_str
        puts "number_str length: #{number_str.length}"

      end 
   
      new_serial = "#{Date.today.strftime('%Y%m%d')}#{number_str}"
    end
    content[2] = new_serial
    Record.skip_callback(:save,:after,:update_soa_record)
    soa.update_attributes content: content.join(" "), change_date: Time.now.to_i
    Record.set_callback(:save,:after,:update_soa_record)
  end
end
