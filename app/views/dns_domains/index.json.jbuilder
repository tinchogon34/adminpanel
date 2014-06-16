json.array!(@zones) do |zone|
  json.extract! zone, :id, :name, :master, :last_check, :type, :notified_serial, :account
  json.url zone_url(zone, format: :json)
end
