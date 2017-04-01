# Bento [![Build Status](https://travis-ci.org/colorbox/bento.svg?branch=master)](https://travis-ci.org/colorbox/bento)

社内向けお弁当注文システムです。

## 使用技術

- Ruby On Rails 5.0.1
- Ruby 2.4.0

## 動かし方

1. リポジトリを clone もしくは fork し、ライブラリをインストールする
```
( git clone してから)

cd path/to/bento
bundle install
```

2. DB のセットアップ

```
cp config/database.yml.sample config/database.yml
bundle exec rake db:create db:migrate db:seed_fu
```

3. 環境変数のセットアップ


```
cp .env.sample .env
```

エディタで `.env` を開き、必要な情報を追加

- `ADMIN_ID`: 管理者（お弁当の注文を取りまとめる人）がダッシュボードにアクセスする際の ID（必須）
- `ADMIN_PASS`: 管理者がダッシュボードにアクセスする際のパスワード（必須）
- `USER_ID`: お弁当を頼みたい人がアクセスする際の ID（必須）
- `USER_PASS`: お弁当を頼みたい人がアクセスする際のパスワード（必須）
- `IDOBATA_HOOK_URL`: Order レコードが作成された際に通知を送る idobata room の WebHook URL（任意）

4. サーバを起動

```
bin/rails server
```
