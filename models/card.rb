class Card
  include ActiveModel::Model

  attr_accessor *%i(
    title
    image
    body
  )
end