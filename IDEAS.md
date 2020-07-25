# Ideas

## Use GameIcons Gem

[Game-Icons.net](http://game-icons.net/)

[Gem Docs](https://squib.readthedocs.io/en/v0.15.0/guides/game_icons.html)

Example:
```
icons = CARDS.map do |card|
    GameIcons.get(card.icon).recolor(fg: '000', bg: 'fff').string
  end
    
  svg data: icons,
    width: 500, height: 500,
    x: 150, y: 150
```

