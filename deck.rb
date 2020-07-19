require 'active_model'
require 'squib'

require_relative "models/card"

# icons from game-icons.net
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

Squib::Deck.new(cards: 2) do
  background color: '#FFFFFF'

  text str: CARDS.map(&:title),
       color: '#000000',
       font: 'ChunkFive Roman,Sans 24',
       y: '2.5in',
       width: '2.75in',
       align: :center

  svg file: CARDS.map(&:image),
      width: 500, height: 500,
      x: 150, y: 250

  save_png
end