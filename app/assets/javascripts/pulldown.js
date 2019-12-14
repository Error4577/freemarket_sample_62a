$(function(){
  // childrenカテゴリのhtml作成
  // function buildCategoryList_Children(category_children, selected_category_root){
  //   category_children.forEach(function(children) {
  //     $(`#${selected_category_root}`).append(buildCategoryBox_children(children));
  //   });

  //   function buildCategoryBox_children(children){
  //     var optionHtmlChild = `<li class="header__menu-box--left__children__child" value="${children.id}">
  //                              <a href="#">${children.name}</a>
  //                              <ul class="header__menu-box--left__grand-children" id="${children.id}"></ul>
  //                            </li>`
  //     return optionHtmlChild;
  //   };
  // };
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

  // rootカテゴリにmouseenterで発火
  // $(document).on("mouseenter",".header__menu-box--left__parents__parent", function(e) {
  //   var selected_category_root = $(this).val();
  //   $.ajax({
  //     url: "/products/get_category_children",
  //     type: "GET",
  //     data: {root_category_id: selected_category_root},
  //     dataType: "json"
  //   })
  //   .done(function(category_children){
  //     buildCategoryList_Children(category_children, selected_category_root);
  //   })
  //   .fail(function(){
  //     console.log('error');
  //   })

  // });
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
// $(function(){

//   function buildCategoryList_Root(category_roots){
//     category_roots.forEach(function(root){
//       $(".product-category__root").append(buildCategoryBox_Root(root));
//     });

//     function buildCategoryBox_Root(root){
//       var optionHtml = `<li id="product_root_category_id" value="${root.id}">
//                           ${root.name}
//                           <ul></ul>
//                         </li>`
//       return optionHtml;
//     };
//   };

//   function buildCategoryList_Children(category_children){
//     category_children.forEach(function(children) {
//       $(".product-category__children").append(buildCategoryBox_children(children));
//     });

//     function buildCategoryBox_children(children){
//       var optionHtml = `<li id="product_children_category_id" value="${children.id}">
//                           ${children.name}
//                         </li>`
//       return optionHtml;
//     };
//   };

//   function buildCategoryList_GrandChildren(category_grandchildren){
//     category_grandchildren.forEach(function(grandchildren) {
//       $(".product-category__grandchildren").append(buildCategoryBox_grandchildren(grandchildren));
//     });

//     function buildCategoryBox_grandchildren(grandchildren){
//       var optionHtml = `<li id="product_grandchildren_category_id" value="${grandchildren.id}">
//                           ${grandchildren.name}
//                         </li>`
//       return optionHtml;
//     };
//   };





  // //header__content__categoryにホバーしたら発火
  // $(document).on("mouseover",".category__select", function(e) {
  //   $.ajax({
  //     url: "/products/get_category_roots",
  //     type: "GET",
  //     dataType: "json"
  //   })
  //   .done(function(category_roots){
  //     //ajax成功時ルートカテゴリのリストを表示する関数を呼び出す
  //     buildCategoryList_Root(category_roots);
  //   })
  //   .fail(function(){
  //     console.log('error');
  //   })

  //   // カテゴリー選択後に、対応するリストを表示させる関数
  // });


//   $(document).on("mouseover","#product_root_category_id", function(e) {
//     $(".product-category__grandchildren").empty();
//     $(".product-category__children").empty();
//     $("#product_root_category_id.active").removeClass("active");
//     $(".product-category__children").addClass("white");

//     var selected_category_root = $(this).val();
//     $("#product_root_category_id").removeClass("active");
//     $(this).addClass("active");
//     // console.log(selected_category_root);
//     $.ajax({
//       url: "/products/get_category_children",
//       type: "GET",
//       data: {root_category_id: selected_category_root},
//       dataType: "json"
//     })
//     .done(function(category_children){
//       //ajax成功時ルートカテゴリのリストを表示する関数を呼び出す
//       buildCategoryList_Children(category_children);
//     })
//     .fail(function(){
//       console.log('error');
//     })

//   });


//   $(document).on("mouseover","#product_children_category_id", function(e) {
//     $(".product-category__grandchildren").empty();
//     $("#product_children_category_id.active").removeClass("active");
//     $(".product-category__grandchildren").addClass("white");

//     var selected_category_children = $(this).val();
//     $("#product_children_category_id").removeClass("active");
//     $(this).addClass("active");
//     // console.log(selected_category_root);
//     $.ajax({
//       url: "/products/get_category_grandchildren",
//       type: "GET",
//       data: {child_category_id: selected_category_children},
//       dataType: "json"
//     })
//     .done(function(category_grandchildren){
//       //ajax成功時ルートカテゴリのリストを表示する関数を呼び出す
//       buildCategoryList_GrandChildren(category_grandchildren);
//     })
//     .fail(function(){
//       console.log('error');
//     })
//   })


//   $(document).on("mouseover","#product_grandchildren_category_id", function(e) {
//     $("#product_grandchildren_category_id.active").removeClass("active");
//     $(this).addClass("active");
//   }).on("mouseleave",".product-category__grandchildren", function(e){
//     $(".product-category__grandchildren").empty();
//     $(".product-category__grandchildren").removeClass("white");
//   });

//   $(document).on("mouseleave",".product-category", function(e) {
//     $(".product-category__children").removeClass("white");
//     $(".product-category div").empty();
//   });

// })
