# Restaurant-Map

道の駅、鉄道駅、宿泊施設、飲食店を表示する全国旅マップです。

## ファイル

- `index.html`：アプリ本体
- `restaurant-builder.html`：指定5チェーン追加ツール
- `restaurants-1.json` / `restaurants-2.json`：飲食店データ（初期合計22,116件）
- `hotels-1.json` / `hotels-2.json`：宿泊施設データ

## GitHub Pages

GitHubのリポジトリ設定で Pages の公開元を `main` ブランチの `/ (root)` に設定してください。

公開URL：`https://pet-salon-manager.github.io/Restaurant-Map/`

チェーン店追加ツール：`https://pet-salon-manager.github.io/Restaurant-Map/restaurant-builder.html`

## 5チェーンの追加方法

1. `restaurant-builder.html`を開きます。
2. 既存飲食店数が22,116件と表示されることを確認します。
3. 「指定チェーン店を追加取得」を押します。
4. 47都道府県の処理後、2つのJSONを保存します。
5. リポジトリの`restaurants-1.json`と`restaurants-2.json`を上書きします。

対象：すき家、吉野家、スシロー、ココス、はま寿司。
