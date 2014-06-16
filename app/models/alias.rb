class Alias < ActiveRecord::Base
  self.table_name = "alias"
  establish_connection "#{Rails.env}_postfix".to_sym
end
