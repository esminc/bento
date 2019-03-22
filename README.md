# Bento [![Build Status](https://travis-ci.org/esminc/bento.svg?branch=master)](https://travis-ci.org/esminc/bento)

社内向けお弁当注文システムです。

## 使用技術

- Ruby on Rails 5.2.2.1
- Ruby 2.5.5

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
bin/rails db:create db:migrate db:seed_fu
```

3. 環境変数のセットアップ（任意）


```
cp .env.sample .env
```

エディタで `.env` を開き、必要な情報を追加

- `ADMIN_ID`: 管理者（お弁当の注文を取りまとめる人）がダッシュボードにアクセスする際の ID
- `ADMIN_PASS`: 管理者がダッシュボードにアクセスする際のパスワード
- `USER_ID`: お弁当を頼みたい人がアクセスする際の ID
- `USER_PASS`: お弁当を頼みたい人がアクセスする際のパスワード
- `IDOBATA_DEVELOPER_HOOK_URL`: Order レコードが作成された際に通知を送る idobata room の WebHook URL
- `IDOBATA_USER_HOOK_URL`: 注文が締め切られた時にお弁当の発注の可否の通知を送る idobata room の WebHook URL

4. サーバを起動

```
bin/rails server
```

5. テストの実行

```
bundle exec rspec spec
```
