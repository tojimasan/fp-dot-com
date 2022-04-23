## プロジェクト概要
- FP.com(FPドットコム)
- FPが作成した予約枠をクライアント(ユーザー)が予約できるシステムです
![画像貼る](https://user-images.githubusercontent.com/46068674/163881315-9a3cf248-18be-4c7f-b8d5-f9458429655c.png)

## 機能
- FP、クライアントの新規登録
- FP、クライアントのログイン、ログアウト
  - 認証にパスワードはないため、存在するユーザーであればどのユーザーにもログイン可能
- ユーザーそれぞれの詳細画面
  - FP
    - 作成した予約枠
    - 枠の作成ボタン
  - クライアント
    - 予約した枠
    - 枠の予約を行えるリンクへの遷移ボタン
- FP限定の機能
  - 予約枠の作成
    - 平日 10:00 ~ 18:00
    - 土曜 11:00 ~ 15:00
    - 日曜 終日不可
    - 一枠の時間は30分固定
- クライアント限定の機能
  - 空いている枠の予約

## 使用言語、バージョン

| ツール名 | バージョン |
| ----------- | ----------- |
| Ruby | 2.7.5 |
| Rails | 6.1.5 |
| MySQL | 8.0 |
| Rspec | 5.1.1 |
| Factory Bot | 6.2.1 |

## ER図

![](https://user-images.githubusercontent.com/46068674/163883843-157035eb-0746-4426-a3d8-18e4a879b8f9.png)

## セットアップ手順

### ローカルにコードを落とす
```bash
cd path/to/directory
git clone git@github.com:tojimasan/fp-dot-com.git
cd fp-dot-com
```

### Dockerをビルド
```bash
docker compose build --no-cache
```

### Dockerを立ち上げる
```bash
docker compose up -d
```

### DBの用意
```bash
docker compose exec web rails db:create
docker compose exec web rails db:migrate
```

### コンパイル
```bash
docker compose exec web rails assets:precompile
```

### localhost:3000でアプリケーションが立ち上がっていることを確認
```
http://localhost:3000/
```

## テスト方法

### Rspecを実行する
```bash
docker compose exec web rspec
```

## 本番リンク

- [Fp.com](https://fp-dot-com.herokuapp.com/)

### 注意点
~~本番はHerokuの無料プランで公開しております。無料プランの関係でリクエストに時間がかかり、503が返ってくることがあります
理由としてはHerokuがリクエストを受け取ってからアプリケーションを起動させるためです。そのため**タイムアウトをした際には再度リロードして下さい。**~~
定期的にアクセスすることでアイドル状態がないようにしています。もし503エラーが発生した場合には再リロードをお願いします。
```bash
2022-04-18T21:31:09.483108+00:00 heroku[router]: at=error code=H20 desc="App boot timeout" method=GET path="/" host=fp-dot-com.herokuapp.com request_id=ad931152-d7f5-4b5b-ab91-88dfbcb30aa5 fwd="153.139.174.138" dyno= connect= service= status=503 bytes= protocol=https
```
