source "http://rubygems.org"

gem "treetop"
gem "parallel"

group :development do
  gem "jeweler"
end

group :test do
  if RUBY_VERSION =~ /^1\.9/
    gem "ruby-debug19", :require => "ruby-debug"
  end
  gem "rspec"
end
