class Api::V1::CurrenciesController < ApplicationController
    def index
        render json: Currency.where(enabled:1)
    end
end
