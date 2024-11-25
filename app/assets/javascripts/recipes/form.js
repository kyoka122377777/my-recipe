document.addEventListener("DOMContentLoaded", () => {
    // 項目追加 (add-section)
    const addSectionButton = document.getElementById("add-section");
    const ingredientsContainer = document.getElementById("ingredients-container");
  
    if (addSectionButton) {
      addSectionButton.addEventListener("click", (e) => {
        e.preventDefault();
        const newSection = document.createElement("div");
        newSection.classList.add("section-group");
  
        newSection.innerHTML = `
          <div class="mb-3">
            <label>項目名</label>
            <input type="text" name="recipe[sections][]" class="form-control" placeholder="例: 調味料, 主材料">
            <button type="button" class="remove-section btn btn-danger mt-2">項目を削除</button>
          </div>
        `;
  
        ingredientsContainer.appendChild(newSection);
  
        // 新しい「項目を削除」ボタンにイベントリスナーを追加
        newSection.querySelector(".remove-section").addEventListener("click", (e) => {
          e.preventDefault();
          newSection.remove();
        });
      });
    }
  
    // 材料追加 (add-ingredient)
    const addIngredientButton = document.getElementById("add-ingredient");
    if (addIngredientButton) {
      addIngredientButton.addEventListener("click", (e) => {
        e.preventDefault();
        const newIngredient = document.createElement("div");
        newIngredient.classList.add("ingredient-group");
  
        newIngredient.innerHTML = `
          <div class="mb-2">
            <label>材料名</label>
            <input type="text" name="recipe[ingredients][]" class="form-control" placeholder="例: 塩,砂糖">
          </div>
          <div class="mb-2">
            <label>分量</label>
            <input type="text" name="recipe[amounts][]" class="form-control" placeholder="例: 少々">
          </div>
          <button type="button" class="remove-ingredient btn btn-danger">材料を削除</button>
        `;
  
        ingredientsContainer.appendChild(newIngredient);
  
        // 新しい「材料を削除」ボタンにイベントリスナーを追加
        newIngredient.querySelector(".remove-ingredient").addEventListener("click", (e) => {
          e.preventDefault();
          newIngredient.remove();
        });
      });
    }
  
    // 既存の削除ボタンにイベントリスナーを追加
    document.querySelectorAll(".remove-section").forEach((button) => {
      button.addEventListener("click", (e) => {
        e.preventDefault();
        button.closest(".section-group").remove();
      });
    });
  
    document.querySelectorAll(".remove-ingredient").forEach((button) => {
      button.addEventListener("click", (e) => {
        e.preventDefault();
        button.closest(".ingredient-group").remove();
      });
    });
  });
  