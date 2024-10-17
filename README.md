# my-recipe
■サービス概要
"my recipe"は自分だけのレシピコレクションから材料別にレシピを検索できる、パーソナルレシピ管理アプリです。タグを使って材料で検索することで、冷蔵庫の中やスーパーの特売に合わせた料理選びが簡単にできます。
コンセプトは"自分の秘伝のレシピブックの作成"

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
