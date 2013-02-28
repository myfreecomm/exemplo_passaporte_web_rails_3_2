# encoding: utf-8

# set these values with your credentials, according to each environment
PASSAPORTE_WEB_TOKEN = 'SRCeyl5ioH'
PASSAPORTE_WEB_SECRET = 'CfRB98YyqXXPNJSrpEAwGVM3OLWHLrAQ'
PASSAPORTE_WEB_URL = 'http://sandbox.app.passaporteweb.com.br'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider OmniAuth::Strategies::PassaporteWeb, PASSAPORTE_WEB_TOKEN, PASSAPORTE_WEB_SECRET, :client_options => {site: PASSAPORTE_WEB_URL}
end
