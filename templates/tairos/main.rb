require_relative "../base"

# need to load cards to local var to allow hotloading while using guard
player_cards = YAML.load(File.read("data/tairos/player_cards.yml")).map { |card| OpenStruct.new(**card) }
races = YAML.load(File.read("data/tairos/races.yml")).map { |card| OpenStruct.new(**card) }
artifacts = YAML.load(File.read("data/tairos/artifacts.yml")).map { |card| OpenStruct.new(**card) }
enemies = YAML.load(File.read("data/tairos/enemies.yml")).map { |card| OpenStruct.new(**card) }
devastations = YAML.load(File.read("data/tairos/devastations.yml")).map { |card| OpenStruct.new(**card) }

cards = (player_cards * 4) + enemies + artifacts + devastations + races
# cards = artifacts

Squib::Deck.new(**DECK_OPTIONS, layout: "layouts/tairos/main.yml", cards: cards.length) do
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
  # Action/Reaction/Free Action
  text layout: :type,
       str: cards.map(&:type),
       y: buffer,
       align: :right

  line x1: buffer,
       x2: Template.width - buffer,
       y1: mm(14),
       y2: mm(14)
  
  
  ## CENTER ICON
  center_icons = cards.map do |card|
    GameIcons.get(card.icon).recolor(fg: '000', bg: 'fff').string
  end

  center_icon_size = mm(32)
  svg data: center_icons,
    width: center_icon_size,
    height: center_icon_size,
    x: (Card.width + border_width - center_icon_size) / 2,
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

  # MONSTER ICONS (if applicable)
  text layout: :hp, str: cards.map { |card| card.hp.nil? ? nil : "HP #{card.hp}" }
  text layout: :attack, str: cards.map { |card| card.attack.nil? ? nil : "#{card.attack} ATK" }

  # SAVE
  # save_png dir: "_output/tairos/png", prefix: cards.map(&:deck), count_format: cards.map(&:title)
  save_pdf dir: "_output/tairos/pdf", file: "full_color.pdf"
end
