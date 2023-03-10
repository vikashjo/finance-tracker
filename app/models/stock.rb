class Stock < ApplicationRecord
	has_many :user_stocks
	has_many :users, through: :user_stocks

	validates :name, :ticker, presence: true
	def self.new_lookup(ticker_symbol)
		client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key], secret_token: 'Tsk_e91737e807fc4b058d1f4dbe509ba174',
  		endpoint: 'https://sandbox.iexapis.com/v1')

  		begin
		new(ticker: ticker_symbol, name:client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
		rescue => exception
			return nil
			end

	end
	def self.check_db(ticker_symbol)
		Stock.where(ticker: ticker_symbol).first		
	end
end
