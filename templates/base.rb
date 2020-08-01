require "game_icons"
require "squib"

require_relative "../models/card"
require_relative "../models/template"

DECK_OPTIONS = {
  width: Template.width,
  height: Template.height
}

CUTLINE_OPTIONS = {
  x: Template.bleed,
  y: Template.bleed,
  width: Card.width,
  height: Card.height,
  dash: 5
}