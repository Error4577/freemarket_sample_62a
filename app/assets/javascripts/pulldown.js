$(function(){
  // grandchildrenカテゴリのhtml作成
  function buildCategoryList_GrandChildren(category_grandchildren, selected_category_children){
    category_grandchildren.forEach(function(grandchildren) {
      $(`#${selected_category_children}`).append(buildCategoryBox_grandchildren(grandchildren));
    });

    function buildCategoryBox_grandchildren(grandchildren){
      var optionHtmlGrandchild = `<li class="header__menu-box--left__grand-children__grand-child">
                                    <a href="#">${grandchildren.name}</a>
                                  </li>`
      return optionHtmlGrandchild;
    };
  };

  // childrenカテゴリにmouseenterで発火
  $(document).on("mouseenter",".header__menu-box--left__children__child", function(e) {
    var selected_category_children = $(this).val();
    $.ajax({
      url: "/products/get_category_grandchildren",
      type: "GET",
      data: {child_category_id: selected_category_children},
      dataType: "json"
    })
    .done(function(category_grandchildren){
      buildCategoryList_GrandChildren(category_grandchildren, selected_category_children);
    })
    .fail(function(){
      console.log('error');
    })

  });

  $(document).on("mouseleave",".header__menu-box--left__children__child", function(e) {
    $(".header__menu-box--left__grand-children__grand-child").remove();
  });


})
