desc "Print directory structure of rails application"

task :tty do
tree = TTY::Tree.new('../ct-covid-tracker', level: 4)
puts tree.render
end