task default: [:latest]

task :latest do
  load 'templates/mtg.rb'
end

# card template for MtG-inspired design
task :mtg do
  load 'templates/mtg.rb'
end

# card template for vertical design
task :vertical do
  load 'templates/vertical.rb'
end

task :guard do
  sh "bundle exec guard -c"
end