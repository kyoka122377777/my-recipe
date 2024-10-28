//= require jquery
//= require rails-ujs

document.addEventListener("DOMContentLoaded", function() {
  const imageInput = document.getElementById('recipe_images');
  const previewContainer = document.getElementById('image-preview');

  imageInput.addEventListener('change', function() {
    previewContainer.innerHTML = ''; // 以前のプレビューをクリア

    const files = imageInput.files;
    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      const reader = new FileReader();
      
      reader.onload = function(e) {
        const img = document.createElement('img');
        img.src = e.target.result;
        img.style.maxWidth = '100px'; // プレビュー画像のサイズ調整
        img.style.margin = '5px';
        previewContainer.appendChild(img); // プレビューコンテナに画像を追加
      };
      
      reader.readAsDataURL(file); // 画像を読み込む
    }
  });
});
document.addEventListener("DOMContentLoaded", function() {
    console.log("DOMが完全に読み込まれました");
    const addButton = document.getElementById("add-quantity");
    const quantitiesDiv = document.getElementById("quantities");
  
    addButton.addEventListener("click", function() {
      const newField = document.createElement("div");
      newField.classList.add("quantity-fields");
      newField.innerHTML = `
        <label for="ingredient_name">材料名</label>
        <input type="text" name="recipe[quantities_attributes][][ingredient_name]" value="">
        <label for="amount_with_unit">分量</label>
        <input type="text" name="recipe[quantities_attributes][][amount_with_unit]" value="">
      `;
      quantitiesDiv.appendChild(newField);
    });
});