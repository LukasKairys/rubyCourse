# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

group :red_green_refactor, halt_on_fail: true, all_on_start: true do
  guard :rspec, cmd: 'rspec', all_on_start: true do
    watch(%r{^app/models/(.+)\.rb$}) { |m| "spec/models/#{m[1]}_spec.rb" }
    watch(%r{^test/models/.+_spec\.rb$})
    watch('spec/spec_helper.rb') { 'spec' }
  end

  guard :rubocop, all_on_start: true do
    watch(%r{^test/models/.+_spec\.rb$})
    watch(%r{^app/models/(.+)\.rb$})
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end

  guard :reek, all_on_start: true do
    watch(%r{^app/models/(.+)\.rb$})
    watch(%r{^test/models/.+_spec\.rb$})
    watch('.reek')
  end
end
