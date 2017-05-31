require 'sinatra/base'
require 'sinatra/flash'
require 'oauth2'
require 'haml'

load 'env.rb' if File.exists?('env.rb')

module Sinatra
  module OAuth2Store
    DEFAULT_API_HOST='https://bo.touch-sell.net/'

    DEFAULT_OAUTH2_PROVIDER='https://bo.touch-sell.net/'

    module Helpers

      def clients
        @clients ||= api.get_clients
      end

      def signed_in?
        current_user != nil
      end

      def current_user
        @current_user ||= api.current_user
      rescue
        session[:access_token] = nil
      end

      def api
        site = ENV['SITE'] || OAuth2Store::DEFAULT_API_HOST
        @api ||= TSAPI.new("#{site}/api/v1/", session[:access_token])
      end

      def oauth2_client(token_method = :post)
        OAuth2::Client.new(
          ENV['OAUTH2_CLIENT_ID'],
          ENV['OAUTH2_CLIENT_SECRET'],
          site: ENV['SITE'] || OAuth2Store::DEFAULT_OAUTH2_PROVIDER,
          token_method: token_method
        )
      end

      def access_token
        OAuth2::AccessToken.new(oauth2_client, session[:access_token], refresh_token: session[:refresh_token])
      end

      def redirect_uri
        ENV['OAUTH2_CLIENT_REDIRECT_URI']
      end

    end

    def self.registered(app)
      app.helpers OAuth2Store::Helpers
      app.enable :sessions
      app.register Sinatra::Flash

      app.get '/sign_in' do
        scope = params[:scope] || 'public read'
        redirect oauth2_client.auth_code.authorize_url(redirect_uri: redirect_uri, scope: scope)
      end

      app.get '/sign_out' do
        session[:access_token] = nil
        redirect '/'
      end

      app.get '/callback' do
        begin
          new_token = oauth2_client.auth_code.get_token(params[:code], redirect_uri: redirect_uri)
          session[:access_token]  = new_token.token
          session[:refresh_token] = new_token.refresh_token
          redirect '/'
        rescue OAuth2::Error
          flash[:error] = params[:error]
          flash[:error_description] = params[:error_description]
          redirect '/'
        end
      end
    end
  end
  #register OAuth2Store
end
