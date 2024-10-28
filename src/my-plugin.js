class MyPlugin {
  apply(compiler) {
  // コンパイル開始時にフックを設定
  compiler.hooks.thisCompilation.tap('MyPlugin', (compilation) => {
    // processAssetsフックを設定
    compilation.hooks.processAssets.tap({
      name: 'MyPlugin',
      stage: compilation.PROCESS_ASSETS_STAGE_OPTIMIZE_SIZE, // 適切なステージを選択
    }, (assets) => {
        // アセットを処理するコードをここに書く
      for (const assetName in assets) {
        const asset = assets[assetName];
        // ここでassetの処理を行う
        console.log(`Processing asset: ${assetName}`);
        }
      });
    });
  }
}
