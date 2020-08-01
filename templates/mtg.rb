require_relative "base"

# need to load cards to local var to allow hotloading while using guard
player_cards = YAML.load(File.read("data/player_decks.yml")).map { |card| OpenStruct.new(**card) }
enemy_cards = YAML.load(File.read("data/enemy_deck.yml")).map { |card| OpenStruct.new(**card) }

cards = player_cards

Squib::Deck.new(**DECK_OPTIONS, layout: "layouts/mtg.yml", cards: cards.length) do
  background color: cards.map(&:border_color)

  border_width = mm(3)
  border = Template.bleed + border_width

  buffer_width = mm(3)
  buffer = border + buffer_width

  # show the cutline as a dashed line
  rect **CUTLINE_OPTIONS

  ## BORDER
  rect x: border, y: border,
       width: Card.width - (border_width * 2),
       height: Card.height - (border_width * 2),
       fill_color: :white

  ## TITLE
  # The name of the card
  text layout: :title,
       str: cards.map(&:title),
       y: buffer
  
  ## TYPE
  # Action/Reaction
  text layout: :type,
       str: cards.map(&:type),
       y: buffer,
       align: :right

  line x1: buffer,
       x2: Template.width - buffer,
       y1: mm(14),
       y2: mm(14)
  
  
  ## CENTER ICON
  icons = cards.map do |card|
    GameIcons.get(card.icon).recolor(fg: '000', bg: 'fff').string
  end

  icon_size = mm(32)
  svg data: icons,
    width: icon_size,
    height: icon_size,
    x: (Card.width + border_width - icon_size) / 2,
    y: mm(18)


  line x1: buffer,
      x2: Template.width - buffer,
      y1: mm(56),
      y2: mm(56)

  ## BODY
  first_line_y = mm(58)
  space_between_lines = mm(5)
  
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

  text layout: :body,
       str: cards.map(&:line5),
       y: first_line_y + (space_between_lines * 4)

  text layout: :body,
       str: cards.map(&:line6),
       y: first_line_y + (space_between_lines * 5)

  save_png prefix: cards.map(&:deck), count_format: cards.map(&:title)
end