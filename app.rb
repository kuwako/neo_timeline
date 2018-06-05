require 'json'
require 'twitter'

json_file_path = './conf.json'
conf = open(json_file_path) do |io|
  JSON.load(io)
end

client = Twitter::REST::Client.new do |config|
  config.consumer_key = conf['consumer_key']
  config.consumer_secret = conf['consumer_secret']
  config.access_token = conf['access_token']
  config.access_token_secret = conf['access_token_secret']
end

tm = nil
al = nil

client.owned_lists.each do |list|
  puts list.name
  if list.name == 'timeline'
    tm = list
  # elsif list.name == 'a'
    # al = list
  end
end

client.friends.each do |friend|
    puts friend.name
    client.add_list_member(tm, friend)
end
