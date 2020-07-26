require_relative "base"

# need to load cards to local var to allow hotloading while using guard
cards = YAML.load(File.read("data/cards.yml")).map { |card| Card.new(**card) }

Squib::Deck.new(**DECK_OPTIONS, layout: "layouts/vertical.yml", cards: cards.length) do
  background color: :white

  # show the cutline as a dashed line
  rect **CUTLINE_OPTIONS

  # The name of the card
  text layout: :title,
       str: cards.map(&:title),
       y: Template.bleed + mm(5)
  
  # Action/Reaction
  text layout: :type,
       str: cards.map(&:type),
       y: Template.bleed + mm(14)

  # The image/icon of the card
  image_size = mm(30)
  svg file: cards.map(&:image),
      width: image_size,
      height: image_size,
      x: Template.bleed + (Card.width - image_size) / 2,
      y: Template.bleed + mm(22)

  # The body text of the card (in 4 lines or less!)
  first_line_y = Template.bleed + mm(56)
  space_between_lines = mm(6)

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