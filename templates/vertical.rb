require_relative "base"

# need to load cards to local var to allow hotloading while using guard
cards = YAML.load(File.read("data/cards.yml")).map { |card| Card.new(**card) }

Squib::Deck.new(**DECK_OPTIONS, layout: "layouts/vertical.yml", cards: cards.length) do
  background color: :white

  # show the cutline as a dashed line
  rect **CUTLINE_OPTIONS

  # The name of the card
  text str: cards.map(&:title), layout: :title,
       y: Template.bleed + inches(0.2)
  
  # Action/Reaction
  text str: cards.map(&:type), layout: :type,
       y: Template.bleed + inches(0.55)

  # The image/icon of the card
  image_size = inches(1.2)
  svg file: cards.map(&:image),
    width: image_size,
    height: image_size,
    x: Template.bleed + (Card.width - image_size) / 2,
    y: Template.bleed + inches(0.85)

  # The body text of the card (in 4 lines or less!)
  body_y = Template.bleed + inches(2.25)
  first_line_y = Template.bleed + inches(2.25)
  space_between_lines = inches(0.25)

  text layout: :body,
       str: cards.map(&:line1),
       y: first_line_y

  text layout: :body,
       str: cards.map(&:line2),
       y: first_line_y + (space_between_lines)

  text layout: :body,
       str: cards.map(&:line3),
       y: first_line_y + (space_between_lines * 2)

  text layout: :body,
       str: cards.map(&:line4),
       y: first_line_y + (space_between_lines * 3)

  save_png prefix: "vertical_"
end