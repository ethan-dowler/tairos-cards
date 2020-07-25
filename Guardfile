group :characters do
  guard 'rake', task: :deck do   # when triggered, run "rake characters"
    watch %r{deck.rb}  # a regular expression that matches our file
    watch %r{.*\.svg}            # Any svg file, anywhere
    watch %r{.*\.yml}            # Any yml file, anywhere
  end
end