json.array!(@mailboxes) do |mailbox|
  json.extract! mailbox, :id, :username, :password, :name, :maildir, :quota, :local_part, :domain, :created, :modified, :active
  json.url mailbox_url(mailbox, format: :json)
end
