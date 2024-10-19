FROM ruby:3.0

# 必要なパッケージをインストール
RUN apt-get update -y && \
    apt-get install -y build-essential libpq-dev

# 作業ディレクトリを作成
WORKDIR /my_recipe

# GemfileとGemfile.lockをコピー（Gemfile.lockが存在しない場合は無視）
COPY Gemfile Gemfile.lock* ./

# Gemのインストール
RUN bundle install

# アプリケーションコードを作業ディレクトリにコピー
COPY . .

# Railsのポートを公開
EXPOSE 3000

# Railsサーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
