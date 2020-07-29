require "active_model"
require "squib"

class Card
  include ActiveModel::Model

  attr_accessor *%i(
    deck
    title
    type
    image
    border_color
    line1
    line2
    line3
    line4
    line5
    line6
  )

  class << self
    def dsl
      dsl ||= Squib::Deck.new
    end

    def width
      @width ||= dsl.mm(63)
    end

    def height
      @height ||= dsl.mm(88)
    end
  end
end
