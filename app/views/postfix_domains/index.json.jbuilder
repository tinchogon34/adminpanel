json.array!(@postfix_domains) do |postfix_domain|
  json.extract! postfix_domain, :id, :domain, :description, :aliases, :mailboxes, :maxquota, :quota, :transport, :backupmx, :created, :modified, :active
  json.url postfix_domain_url(postfix_domain, format: :json)
end
