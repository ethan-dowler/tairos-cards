require "active_model"
require "game_icons"
require "squib"

require_relative "models/card"

# icons from game-icons.net
# TODO: make this work with Guard
CARDS = [
  Card.new(
    title: "Strike",
    image: "images/guardian/battle-axe.svg",
    body:  "Deal 3 damage."
  ),
  Card.new(
    title: "Block",
    image: "images/guardian/round-shield.svg",
    body:  "Prevent 2 damage."
  )
]

deck_dsl = Squib::Deck.new
card_width = deck_dsl.inches(2.5)
card_height = deck_dsl.inches(3.5)
bleed = deck_dsl.inches(0.125)

template_width = card_width + (bleed * 2)
template_height = card_height + (bleed * 2)

Squib::Deck.new(cards: CARDS.length, width: template_width, height: template_height) do
  background color: :white

  rect x: bleed,
       y: bleed,
       width: card_width,
       height: card_height,
       dash: 5

  text str: CARDS.map(&:title),
       color: :black,
       font: 'ChunkFive Roman,Sans 24',
       x: bleed,
       y: bleed + 100,
       width: card_width,
       align: :center

  image_size = inches(1.5)
  svg file: CARDS.map(&:image),
    width: image_size,
    height: image_size,
    x: bleed + (card_width - image_size) / 2,
    y: bleed + inches(0.65)

  save_png
end