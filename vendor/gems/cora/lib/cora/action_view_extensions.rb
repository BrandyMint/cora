module Cora
  module ActionViewExtensions
    module ContentPlacers
      def cora key
        element = Cora::Element.new key

        element.read self
      end
    end
  end
end

ActionView::Base.send :include, Cora::ActionViewExtensions::ContentPlacers
