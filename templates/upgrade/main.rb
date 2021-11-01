require_relative "../base"

# need to load cards to local var to allow hotloading while using guard
cards = YAML.load(File.read("data/upgrade/cards2.yml")).map { |card| OpenStruct.new(**card) }

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
  upgrade_points_labels = cards.map do |card|
    card.upgrade_points.nil? ? nil : "UP"
  end
  text layout: :upgrade_points_label, str: upgrade_points_labels
  text layout: :upgrade_points, str: cards.map(&:upgrade_points)
  
  # PLUS POINTS (if applicable)
  plus_points_labels = cards.map do |card|
    card.plus_points.nil? ? nil : "+P"
  end
  text layout: :plus_points_label, str: plus_points_labels
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
  hp_labels = cards.map do |card|
    card.hp.nil? ? nil : "HP"
  end
  text layout: :hp_label, str: hp_labels

  power_attack_labels = cards.map do |card|
    card.power_attack.nil? ? nil : "POW"
  end
  text layout: :power_attack_label, str: power_attack_labels
  normal_attack_labels = cards.map do |card|
    card.normal_attack.nil? ? nil : "NRM"
  end
  text layout: :normal_attack_label, str: normal_attack_labels
  special_attack_labels = cards.map do |card|
    card.special_attack.nil? ? nil : "SPC"
  end
  text layout: :special_attack_label, str: special_attack_labels

  # STATS (if applicable)
  text layout: :hp,               str: cards.map(&:hp)
  text layout: :power_attack,   str: cards.map(&:power_attack)
  text layout: :normal_attack, str: cards.map(&:normal_attack)
  text layout: :special_attack,   str: cards.map(&:special_attack)

  # SAVE
  save_png dir: "_output/upgrade", prefix: cards.map(&:deck), count_format: cards.map(&:title)
  # save_pdf dir: "_output/upgrade", prefix: cards.map(&:deck), count_format: cards.map(&:title)
end
