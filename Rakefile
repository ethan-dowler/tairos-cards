task default: [:deck]

# card template for MtG-inspired design
task :deck do
  load 'templates/mtg.rb'
end

task :card_backs do
  load 'templates/card_back.rb'
end

task :guard do
  sh "bundle exec guard -c"
end