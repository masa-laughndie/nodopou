source 'https://rubygems.org'

gem 'rails',                    '5.1.4'    #rails各コマンド
gem 'bcrypt',               '~> 3.1.11'    #暗号化(ハッシュ化)
gem 'faker',                    '1.7.3'    #疑似ユーザー追加
gem 'carrierwave',              '1.2.2'    #画像アップローダー
gem 'mini_magick',              '4.7.0'    #
gem 'piet',                     '0.2.6'
gem 'puma',                     '4.3.12'   #serverに使用
gem 'sass-rails',               '5.0.6'    #sass使用のため
gem 'uglifier',                 '3.2.0'    #jsの軽量化?
gem 'coffee-rails',             '4.2.2'    #coffeer.script使用のため
gem 'jquery-rails',             '4.3.1'    #js使用のため
gem 'jquery-turbolinks',        '2.1.0'
gem 'turbolinks',               '5.0.1'    #
gem 'kaminari',                 '1.1.1'
gem 'jbuilder',                 '2.7.0'    #
gem 'font-awesome-rails',     '4.7.0.3'    #
gem 'omniauth',              '~> 1.8.1'
gem 'omniauth-twitter',      '~> 1.4.0'
gem 'twitter',                  '6.2.0'
gem 'dotenv-rails',          '~> 2.2.1'    #key管理
gem 'rack-rewrite',          '~> 1.5.1'    #ドメイン統合
gem 'gon',                   '~> 6.2.0'
gem 'hypernova'

group :development, :test do
  gem 'sqlite3',       '1.3.13'
  gem 'pry-rails',  '~> 0.3.6'
  gem 'pry-byebug', '~> 3.6.0'
  gem 'pry-doc',    '~> 0.13.1'
end


group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
end

group :production do
  gem 'pg', '0.20.0'
  gem 'fog', '1.42'
end

# For Windows development
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]