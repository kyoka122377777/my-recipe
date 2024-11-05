import 'bootstrap';
import '../stylesheets/application';

document.addEventListener("DOMContentLoaded", () => {
  const imageInput = document.getElementById('recipe_images'); // form.file_fieldで設定したID
  const previewContainer = document.getElementById('preview-container'); // プレビュー用の要素を準備

  if (imageInput) {
    imageInput.addEventListener("change", (event) => {
      // プレビューを初期化
      previewContainer.innerHTML = "";

      // 選択された画像ファイルをプレビュー
      Array.from(event.target.files).forEach((file) => {
        const fileReader = new FileReader();

        fileReader.onload = (e) => {
          const img = document.createElement("img");
          img.src = e.target.result;
          img.style.width = "50px"; // 必要に応じてサイズ調整
          img.style.height = "auto";
          previewContainer.appendChild(img);
        };

        fileReader.readAsDataURL(file);
      });
    });
  }
});
