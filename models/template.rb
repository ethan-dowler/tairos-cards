require "squib"
require_relative "card"

module Template
  class << self
    def dsl
      dsl ||= Squib::Deck.new
    end

    def bleed
      @bleed ||= dsl.mm(3)
    end

    def width
      @width ||= Card.width + (bleed * 2)
    end

    def height
      @height ||= Card.height + (bleed * 2)
    end
  end
end