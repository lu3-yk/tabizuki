$(document).ready(function () {
  // 親カテゴリーを表示
  $('#categoBtn').hover(function (e) {
    e.preventDefault();
    e.stopPropagation();
    $('#tree_menu').show();
    $('.prefectureTree').show();
  }, function () {
    // あえて何も記述しない
  });

  // 非同期にてヘッダーのカテゴリーを表示
  function childBuild(children) {
    let child_prefecture = `
                        <li class="prefecture_child">
                          <a href="/tweets/${children.id}/search"><input class="child_btn" type="button" value="${children.name}" name= "${children.id}">
                          </a>
                        </li>
                        `
    return child_prefecture;
  }

  // 親カテゴリーを表示
  $('#categoBtn').hover(function (e) {
    e.preventDefault();
    e.stopPropagation();
    timeOut = setTimeout(function () {
      $('#tree_menu').show();
      $('.prefectureTree').show();
    }, 500)
  }, function () {
    clearTimeout(timeOut)
  });

  // 子カテゴリーを表示
  $('.parent_btn').hover(function () {
    $('.parent_btn').css('color', '');
    $('.parent_btn').css('background-color', '');
    let prefectureParent = $(this).attr('name');
    timeParent = setTimeout(function () {
      $.ajax({
          url: '/tweets',
          type: 'GET',
          data: {
            parent_id: prefectureParent
          },
          dataType: 'json'
        })
        .done(function (data) {
          $(".prefecture_child").remove();
          $('.prefectureTree-child').show();
          data.forEach(function (child) {
            let child_html = childBuild(child)
            $(".prefectureTree-child").append(child_html);
          });
          $('#tree_menu').css('max-height', '490px');
        })
        .fail(function () {
          alert("カテゴリーを選択してください");
        });
    }, 400)
  }, function () {
    clearTimeout(timeParent);
  });

  // カテゴリー一覧ページのボタン
  $('#all_btn').hover(function (e) {
    e.preventDefault();
    e.stopPropagation();
    $(".prefectureTree-child").hide();
    $(".prefecture_child").remove();
  }, function () {
    // あえて何も記述しないことで親要素に外れた際のアクションだけを伝搬する
  });

  // カテゴリーを非表示(カテゴリーメニュから0.8秒以上カーソルを外したら消える)
  $(document).on({
    mouseleave: function (e) {
      e.stopPropagation();
      e.preventDefault();
      timeChosed = setTimeout(function () {
        $(".prefectureTree-child").hide();
        $(".prefectureTree").hide();
        $(this).hide();
        $('.parent_btn').css('color', '');
        $('.parent_btn').css('background-color', '');
        $(".prefecture_child").remove();
      }, 800);
    },
    mouseenter: function () {
      timeChosed = setTimeout(function () {
        $(".prefectureTree-child").hide();
        $(".prefectureTree").hide();
        $(this).hide();
        $('.parent_btn').css('color', '');
        $('.parent_btn').css('background-color', '');
        $(".prefecture_child").remove();
      }, 800);
      clearTimeout(timeChosed);
    }
  }, '#tree_menu');

  // カテゴリーボタンの処理
  $(document).on({
    mouseenter: function (e) {
      e.stopPropagation();
      e.preventDefault();
      timeOpened = setTimeout(function () {
        $('#tree_menu').show();
        $('.prefectureTree').show();
      }, 500);
    },
    mouseleave: function (e) {
      e.stopPropagation();
      e.preventDefault();
      clearTimeout(timeOpened);
      $(".prefectureTree-child").hide();
      $(".prefectureTree").hide();
      $("#tree_menu").hide();
      $(".prefecture_child").remove();
    }
  }, '.header__headerInner__nav__listsLeft__item');
});