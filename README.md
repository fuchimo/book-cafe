# README

# アプリ名
## BookCafe

# 概要

ユーザー登録を行うことで、自分が読んだ本のレビューを投稿することができます。
また、他の人が投稿したレビューも見ることができ、コメントを残すこともできます。
(見るだけならばはログインは不要ですが、コメントを残す場合はユーザー登録が必要です)
他の人の読んだ本に興味があったり、レビューに共感をした場合はお気に入りに登録することも可能です。
自分が投稿した本やお気に入りに登録した本はマイページからいつでも確認可能です。
自分が読んでみたい、もしくはどんな本なのか知りたい場合は検索機能を使って調べることもできます。

# 本番環境
http://35.73.135.101

ID：fuchimo
Pass：1988

# 制作意図

私自身の趣味が読書ということもあり、もっと本好きな人たちと繋がりたいと思いました。
本を読んで感じることは、読んだ人それぞれであり「自分はこの物語からこんなことを感じたけど、他の人はどう感じたんだろう？」と思っていたこともあり、今回、簡単に読んだ本のレビューを共有できるアプリを作成いたしました。
また、自分が知りたい本の情報がすぐに手に入りやすいようにできるだけ検索機能を充実させました。

# 工夫したポイント
ユーザーがいろいろなレビューを探しやすいように検索機能をタイトルと著者から検索できるようにしました。
またカテゴリー別でも検索を行うことができます。
それぞれにリンクを作成し、出版社別でも一覧表示できるようにしています。
お気に入り機能を実装してマイページで一覧表示できるようにすることでお気に入りした本にすぐにアクセスできるようにしています。

# アプリ機能
トップページ（ページネーション機能搭載)  
![ページネーション機能](https://user-images.githubusercontent.com/78131798/111947271-76022b00-8b20-11eb-8773-1bdf05396927.gif)

レビュー投稿画面にプレビュー機能搭載  
![プレビュー機能](https://user-images.githubusercontent.com/78131798/111947418-cbd6d300-8b20-11eb-84a7-44955af7dccd.gif)

コメント投稿機能(非同期通信)  
![コメント投稿](https://user-images.githubusercontent.com/78131798/111947514-fe80cb80-8b20-11eb-8cb9-6c1c14b960fb.gif)

お気に入り登録機能(非同期通信)  
![お気に入り登録](https://user-images.githubusercontent.com/78131798/111947595-296b1f80-8b21-11eb-9d6e-e0d475df68ff.gif)

検索機能  
![著者・タイトル検索](https://user-images.githubusercontent.com/78131798/111947657-3f78e000-8b21-11eb-9dd6-4612f382fcd2.gif)  
![カテゴリー検索](https://user-images.githubusercontent.com/78131798/111947716-591a2780-8b21-11eb-9526-f35976ffc6f6.gif)  


# 開発環境
・Ruby
・Ruby on Rails 
・JavaScript
・jQuery
・Bootstrap
・Visual Studio Code
・AWS（EC2 / E3）

# 今後の課題
「本好きな人たちと繋がる」という観点から、もっとレビュー者同士のコミュニケーションが活発にできるような仕組みの実装が必要だと考えています。
また、登録した住所をもとに、近くの本屋さんやBookCafeの一覧表示ができたら便利かなとも考えています。


# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| birth_date         | date   | null: false               |

### Association

- has_many :books
- has_one :address
- has_many :comments
- has_many :favorites
- has_many :fav_books, through: :favorites, source: :book

## addresses テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | string     | null: false                    |
| prefecture_id   | integer    | null: false                    |
| city            | string     | null: false                    |
| house_number    | string     | null: false                    |
| building_number | string     |                                |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user, optional: true

## books テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| title       | string     | null: false                    |
| author      | string     | null: false                    |
| publisher   | string     | null: false                    |
| category_id | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one_attached :image
- has_one :review, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :favorites, dependent: :destroy
- has_many :users, through: :favorites

## reviews テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | text       | null: false                    |
| book    | references | null: false, foreign_key: true |

### Association

- belongs_to :book

## favorites テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| book    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :book

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| book    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :book
