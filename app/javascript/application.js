// Rails UJSをインポート
import Rails from "@rails/ujs";
Rails.start();

// ActiveStorageのインポート
import * as ActiveStorage from "activestorage";
ActiveStorage.start();

// Stimulusコントローラーのインポート
import "controllers";

// 必要なJavaScriptファイルのインポート
import "./recipes/form"; // 個別ファイルもインポートする
