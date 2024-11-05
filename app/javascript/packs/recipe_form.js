document.addEventListener("DOMContentLoaded", function() {
    const addQuantityButton = document.getElementById("add-quantity");
    const quantitiesContainer = document.getElementById("quantities");
  
    // 「add-quantity」ボタンのクリックイベント
    addQuantityButton.addEventListener("click", function() {
      const index = quantitiesContainer.children.length; // 現在の数量フィールドの数を取得
      const newField = document.createElement("div");
      newField.classList.add("quantity-fields", "mb-3");
  
      newField.innerHTML = `
        <label for="quantities_attributes[${index}][ingredient_name]">材料名</label>
        <input type="text" name="quantities_attributes[${index}][ingredient_name]" class="form-control" />
  
        <label for="quantities_attributes[${index}][amount_with_unit]">量と単位</label>
        <input type="text" name="quantities_attributes[${index}][amount_with_unit]" class="form-control" />
      `;
  
      quantitiesContainer.appendChild(newField);
    });
  
    // 画像プレビューの機能
    const imageInput = document.getElementById("recipe_images");
    const imagePreview = document.getElementById("image-preview");
  
    imageInput.addEventListener("change", function() {
      imagePreview.innerHTML = ""; // 以前のプレビューをクリア
  
      Array.from(imageInput.files).forEach(file => {
        const reader = new FileReader();
        reader.onload = function(e) {
          const img = document.createElement("img");
          img.src = e.target.result;
          img.classList.add("img-thumbnail", "me-2"); // Bootstrapのクラスを使用してスタイリング
          img.style.width = 50% // プレビュー画像の幅を設定
          imagePreview.appendChild(img);
        };
        reader.readAsDataURL(file);
      });
    });
  });
  