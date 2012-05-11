yml = YAML.load_file("#{Rails.root}/config/authorize_net.yml")
AUTHORIZE_NET_CONFIG = yml['default']
AUTHORIZE_NET_CONFIG.merge!(yml[Rails.env]) unless yml[Rails.env].nil?
AUTHORIZE_NET_CONFIG.freeze

AUTHORIZE_TRANSACTION_URL = "https://secure.authorize.net/gateway/transact.dll "
AUTHORIZE_DATA_VALIDATION_URL = "https://developer.authorize.net/tools/paramdump/index.php"
