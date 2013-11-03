module Cora
  class ElementsController < ApplicationController
    def update
      e = Cora::Element.new params[:key]
      e.content = params[:content]

      render json: []
    end

    def index
      render json: Cora.backend.element_keys.sort
    end
  end
end
