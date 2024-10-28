/******/ (function() { // webpackBootstrap
/******/ 	/************************************************************************/
/*!*********************************************!*\
  !*** ./app/javascript/packs/application.js ***!
  \*********************************************/
document.addEventListener("DOMContentLoaded", function () {
  var imageInput = document.getElementById('recipe_images');
  var previewContainer = document.getElementById('image-preview');
  imageInput.addEventListener('change', function () {
    previewContainer.innerHTML = ''; // 以前のプレビューをクリア

    var files = imageInput.files;
    for (var i = 0; i < files.length; i++) {
      var file = files[i];
      var reader = new FileReader();
      reader.onload = function (e) {
        var img = document.createElement('img');
        img.src = e.target.result;
        img.style.maxWidth = '100px'; // プレビュー画像のサイズ調整
        img.style.margin = '5px';
        previewContainer.appendChild(img); // プレビューコンテナに画像を追加
      };
      reader.readAsDataURL(file); // 画像を読み込む
    }
  });
});
document.addEventListener("DOMContentLoaded", function () {
  console.log("DOMが完全に読み込まれました");
  var addButton = document.getElementById("add-quantity");
  var quantitiesDiv = document.getElementById("quantities");
  addButton.addEventListener("click", function () {
    var newField = document.createElement("div");
    newField.classList.add("quantity-fields");
    newField.innerHTML = "\n        <label for=\"ingredient_name\">\u6750\u6599\u540D</label>\n        <input type=\"text\" name=\"recipe[quantities_attributes][][ingredient_name]\" value=\"\">\n        <label for=\"amount_with_unit\">\u5206\u91CF</label>\n        <input type=\"text\" name=\"recipe[quantities_attributes][][amount_with_unit]\" value=\"\">\n      ";
    quantitiesDiv.appendChild(newField);
  });
});
/******/ })()
;
//# sourceMappingURL=application-9793ffc6b1f19fba6b85.js.map