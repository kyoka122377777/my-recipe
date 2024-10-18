# my-recipe
■サービス概要
My Recipeは、ユーザーが自分のオリジナルレシピを簡単に登録・管理できるウェブアプリケーションです。ユーザーは、材料やタグを使ってレシピを整理し、検索することで、料理のアイデアを引き出すことができます。また、レシピには画像を添付でき、視覚的に料理のイメージを強化します。

目的
本サービスは、料理を楽しむすべての人に向けて、手軽にレシピを管理し、必要なときに素早く検索できる機能を提供することを目的としています。特に、家にある食材をもとに新しい料理を提案することに重点を置きます。

主な機能
ユーザー登録機能: ユーザーは、ユーザーネーム、メールアドレス、パスワードを用いて新規登録できます。
ログイン機能: 登録したユーザーは、メールアドレスとパスワードでログインできます。
ユーザーネーム、メールアドレス、パスワード変更機能: ユーザーは、アカウント情報をいつでも変更できます。
レシピ投稿機能: ユーザーは、オリジナルレシピを投稿でき、必要に応じて画像を添付できます。
レシピ編集機能: 投稿したレシピを後から編集できます。
レシピ削除機能: 不要になったレシピは削除できます。
レシピ検索機能: タグや材料を使って、簡単にレシピを検索できます。
タグ作成機能: ユーザーは、レシピに関連するタグを作成し、レシピを整理できます。
ターゲットユーザー
料理を楽しむすべての人々をターゲットとし、特に自宅で料理をする人々に向けて提供します。冷蔵庫の食材を活用したレシピ提案機能により、無駄を減らしながら新しい料理のアイデアを提供します。

■ このサービスへの思い・作りたい理由
料理が好きでいろいろなレシピを試しているうちに、得意な料理やお気に入りのレシピをもっと整理したいと思うようになりました。
特にスーパーで食材が安くなっている時や旬のお食材が出ている時に、どんな料理を作るか悩むことが多かったため、手元のレシピをすぐに検索できる仕組みがあれば便利だと感じ、開発を決めました。

■ ユーザー層について
料理が好きな人、料理をよくする家庭の主婦・主夫、食材にこだわる人
自分のレシピをまとめたい人、レシピサイトではなく、自分の好きなレシピを効率的に探したい人
この層を対象にした理由は、日々の料理をより効率的に楽しめるツールが求められていると感じたからです。また、特定の材料を使ったレシピを探すというニーズは多くの料理愛好者に共通しています。
■サービスの利用イメージ
ユーザーは、料理をしたときにmy-recipeにレシピを登録し、材料ごとにタグを付けます。後日、スーパーで豚肉が安くなったとき、アプリで「豚肉」のタグを検索することで、自分の得意料理やお気に入りレシピの中から豚肉を使ったレシピを素早く見つけられます。これにより、食材を無駄にせず、効率的に活用できる利点があります。

■ ユーザーの獲得について
まずは料理好きのユーザー層に対してSNSでのプロモーションを行う予定です。
また、食材やレシピに興味のあるブログやコミュニティにもアプローチし、サービスを広める予定です。

■ サービスの差別化ポイント・推しポイント
多くのレシピサイトが存在しますが、RecipeTrackerは他のサイトから取得したレシピではなく、自分の得意料理や実際に作ったレシピを蓄積・検索できる点がユニークです。
また、材料でのタグ検索機能は、日常の買い物や料理計画に非常に便利なツールとなるでしょう。

■ 機能候補
MVPリリース時
レシピ登録機能（材料ごとのタグ付け）
タグによるレシピ検索機能
レシピ編集・削除機能

本リリースまでに作りたい機能
お気に入り機能
レシピのシェア機能（SNS連携）
レシピのカスタマイズ機能（メモ追加など）
独自のタグシステム: 材料だけでなく、調理方法（焼く、煮る、蒸すなど）や料理の種類（和食、中華、洋食など）もタグ付けできるようにし、ユーザーが多様な検索を行えるようにします。
フィルタ機能: 検索結果を「調理時間」「カロリー」「難易度」などのフィルタで絞り込めるようにする。これらをMVPリリース後の追加機能として提案します。

■ 機能の実装方針予定
シンプルで使いやすいUIを意識しつつ、まずは基本機能（レシピ登録・タグ検索）を優先的に実装します。その後、ユーザーからのフィードバックを基に、必要な追加機能や改善を行っていきます。また、Ruby on Railsを使用して迅速な開発とデプロイを目指します。

MVPリリースまでのタスク
- [ ]  rails new
- [ ] トップページ作成
- [ ] ユーザー登録機能実装
- [ ]  ログイン機能実装
- [ ] レシピ投稿機能実装
- [ ] タグ作成機能実装
- [ ] レシピ検索機能実装
- [ ] レシピ編集機能実装
- [ ] レシピ削除機能実装
- [ ] アカウント管理画面作成（ユーザーネーム、メールアドレス、パスワード変更）

本リリースまでに作りたい機能
- [ ]  お気に入り機能
- [ ] レシピのシェア機能（SNS連携）
- [ ] レシピのカスタマイズ機能（メモ追加など）
- [ ]  独自のタグシステム: 材料だけでなく、調理方法や料理の種類もタグ付け可能にする。
- [ ] フィルタ機能: 検索結果を「調理時間」「カロリー」「難易度」などで絞り込む。
