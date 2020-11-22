task default: [:main]

task :main do
  load 'templates/tairos/main.rb'
end

namespace :tairos do
  task :main do
    load 'templates/tairos/main.rb'
  end

  task :colorless do
    load 'templates/tairos/colorless.rb'
  end
  
  task :card_backs do
    load 'templates/tairos/card_back.rb'
  end

  task :colorless_card_backs do
    load 'templates/tairos/colorless_card_back.rb'
  end
end

namespace :upgrade do
  task :main do
    load 'templates/upgrade/main.rb'
  end
end

task :guard do
  sh "bundle exec guard -c"
end
