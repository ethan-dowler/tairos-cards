require "squib"

require_relative "models/card"

# icons from game-icons.net
# TODO: make this work with Guard
cards = [
  Card.new(
    title: "Strike",
    type: "Reaction",
    image: "guardian/battle-axe.svg",
    line1: "Deal 3 damage.",
    line2: "If you <i>Strike</i> an enemy",
    line3: "who damaged you this",
    line4: "Round, deal 5 instead.",
  ),
]

# can only access the #inches function on an instance of Deck
deck_dsl = Squib::Deck.new

card_width = deck_dsl.inches(2.5)
card_height = deck_dsl.inches(3.5)

bleed = deck_dsl.inches(0.125)
template_width = card_width + (bleed * 2)
template_height = card_height + (bleed * 2)

Squib::Deck.new(
  cards: cards.length,
  width: template_width,
  height: template_height,
  layout: 'layout.yml'
) do
  background color: :white

  # show the cutline as a dashed line
  rect x: bleed,
       y: bleed,
       width: card_width,
       height: card_height,
       dash: 5

  # The name of the card
  text str: cards.map(&:title),
       layout: :title_text,
       y: bleed + inches(0.2)
  
  # Card Type
  text str: cards.map(&:type),
       layout: :type_text,
       y: bleed + inches(0.55)

  # The image/icon of the card
  image_size = inches(1.2)
  svg file: cards.map(&:image),
    width: image_size,
    height: image_size,
    x: bleed + (card_width - image_size) / 2,
    y: bleed + inches(0.85)

  # The body text of the card (in 4 lines or less!)
  body_y = bleed + inches(2.25)
  first_line_y = bleed + inches(2.25)
  space_between_lines = inches(0.25)

  text str: cards.map(&:line1),
    layout: :body_text,
    y: first_line_y

  text str: cards.map(&:line2),
    layout: :body_text,
    y: first_line_y + (space_between_lines)

    text str: cards.map(&:line3),
    layout: :body_text,
    y: first_line_y + (space_between_lines * 2)

    text str: cards.map(&:line4),
    layout: :body_text,
    y: first_line_y + (space_between_lines * 3)

  save_png
end