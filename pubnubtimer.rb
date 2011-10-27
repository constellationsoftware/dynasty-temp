## Pubnub.new(pub_key, sub_key)
pubnub = Pubnub.new( 'pub-fb4dbf08-55b4-4c73-a401-8bfa84b459e5', 'sub-92c8bd6b-cde8-11e0-8532-190f3ed4faac' )
pubnub.publish({'channel' => 'dynasty_test', 'message' => { 'ping' => 'ping' }})

pubnub = Pubnub.new(
    "pub-fb4dbf08-55b4-4c73-a401-8bfa84b459e5",  ## PUBLISH_KEY
    "sub-92c8bd6b-cde8-11e0-8532-190f3ed4faac",  ## SUBSCRIBE_KEY
    "",      ## SECRET_KEY
    false    ## SSL_ON?
)

messages = pubnub.history({
    'channel' => 'dynasty_test',
    'limit'   => 10
})

info = pubnub.publish({
    'channel' => 'dynasty_test',
    'message' => { 'text' => 'some text data' }
})
puts(info)