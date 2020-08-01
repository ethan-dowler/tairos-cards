require "squib"

module Card
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
