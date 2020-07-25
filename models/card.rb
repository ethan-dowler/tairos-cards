require "active_model"

class Card
  include ActiveModel::Model

  attr_accessor *%i(
    title
    image
    line1
    line2
    line3
    line4
  )
end