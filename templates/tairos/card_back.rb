require_relative "../base"

# need to load cards to local var to allow hotloading while using guard
card_backs = YAML.load(File.read("data/tairos/card_backs.yml")).map { |card| OpenStruct.new(**card) }
cards = card_backs * 3

Squib::Deck.new(**DECK_OPTIONS, cards: cards.length) do
  background color: "#111"

  border_width = mm(3)
  border = Template.bleed + border_width

  # show the cutline as a dashed line
  rect **CUTLINE_OPTIONS

  ## BORDER
  rect x: border, y: border,
       width: Card.width - (border_width * 2),
       height: Card.height - (border_width * 2),
       fill_color: cards.map(&:background_color)


  ## ICONS
  center_icons = cards.map do |card|
    GameIcons.get(card.center_icon).recolor(fg: card.icon_color, bg: card.background_color).string
  end
  left_icons = cards.map do |card|
    GameIcons.get(card.left_icon).recolor(fg: card.icon_color, bg: card.background_color).string
  end
  right_icons = cards.map do |card|
    GameIcons.get(card.right_icon).recolor(fg: card.icon_color, bg: card.background_color).string
  end

  icon_size = mm(16)
  center_icon_x = (Template.width - icon_size) / 2
  center_icon_y = mm(22)
  left_right_icon_offset_x = mm(14)
  left_right_icon_offset_y = mm(28)
  # center icon
  svg width: icon_size,
      height: icon_size,
      data: center_icons,
      x: center_icon_x,
      y: center_icon_y
  # left icon
  svg width: icon_size,
      height: icon_size,
      data: left_icons,
      x: center_icon_x - left_right_icon_offset_x,
      y: center_icon_y + left_right_icon_offset_y
  # right icon
  svg width: icon_size,
      height: icon_size,
      data: right_icons,
      x: center_icon_x + left_right_icon_offset_x,
      y: center_icon_y + left_right_icon_offset_y

  # SAVE
  # save_png dir: "_output/tairos/png", prefix: cards.map(&:deck), count_format: "Card Back"
  save_pdf dir: "_output/tairos/pdf", file: "card_backs.pdf"
end
