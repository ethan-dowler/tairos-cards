require_relative "../base"

# need to load cards to local var to allow hotloading while using guard
units = YAML.load(File.read("data/upgrade/units.yml")).map { |card| OpenStruct.new(**card) }

cards = units

Squib::Deck.new(**DECK_OPTIONS, layout: "layouts/upgrade/main.yml", cards: cards.length) do
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

  
  # UPGRADE POINTS LABELS (if applicable)
  text layout: :upgrade_points_label, str: "UP"
  text layout: :upgrade_points, str: cards.map(&:upgrade_points)
  
  # PLUS POINTS (if applicable)
  text layout: :plus_points_label, str: "+P"
  text layout: :plus_points, str: cards.map(&:plus_points)

  ## BODY - 4 lines
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

  # STAT LABELS (if applicable)
  text layout: :hp_label,               str: "HP"
  text layout: :primary_attack_label,   str: "PRI"
  text layout: :secondary_attack_label, str: "SEC"
  text layout: :special_attack_label,   str: "SPE"

  # STATS (if applicable)
  text layout: :hp,               str: cards.map(&:hp)
  text layout: :primary_attack,   str: cards.map(&:primary_attack)
  text layout: :secondary_attack, str: cards.map(&:secondary_attack)
  text layout: :special_attack,   str: cards.map(&:special_attack)

  # SAVE
  save_png dir: "_output/upgrade", prefix: cards.map(&:deck), count_format: cards.map(&:title)
end