# RPP
ロールプレイング風に作成したポートフォリオです。
バックエンドはRuby on RailsをAPIモードで作成し、フロントエンドはRiot.jsを使用しシンプルなSPA構成になっています。

公開URL
~~http://54.199.233.154:8080/~~

トップ画面<br>
![トップページ](https://media.giphy.com/media/jfOrmxreYfVgJJ4usu/giphy.gif "トップページ")

ホーム画面<br>
![ホーム](https://media.giphy.com/media/bOmQitGcRMg0yRGm2s/giphy.gif "ホーム")

バトル画面<br>
![バトル](https://media.giphy.com/media/1gqDCDOtsVOBv5mEFs/giphy.gif "バトル")

# 使用技術
## バックエンド
* ruby 2.7.2
* Ruby on Rails 6.1.3.1

## フロントエンド
* Riot.js 4.11.0
* typed.js ^2.0.11(文字出力に使用)
* nes.css 2.2.1(ゲーム風UIに使用)
* webpack 4.44.2

## インフラ
* EC2
* RDS
* docker
* docker-compose

# 起動方法
1. リポジトリをclone

2. dockerコンテナ起動

```
docker-compose up
```

3. db構築
```
docker-compose exec web bundle exec rake db:create db:migrate 
```

```
docker-compose exec web bundle exec rake db:seed db:migrate 
```
