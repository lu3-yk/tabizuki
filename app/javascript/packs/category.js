$(document).on('turbolinks:load', function() {
$(function(){
  function appendOption(prefecture){
    var html = `<option value="${prefecture.id}">${prefecture.name}</option>`;
    return html;
  }
  function appendSelectedOption(prefecture) {
    var html = `<option value="${prefecture.id}" selected=\"selected\">${prefecture.name}</option>`;
    return html;
  }
  function appendChildrenBox(insertHTML){
    var childSelectHtml = "";
    childSelectHtml = `<div class="prefecture__child" id="children_wrapper">
                        <select id="child__prefecture" name="tweet[prefecture_id]" class="serect_field">
                          <option value="">---</option>
                          ${insertHTML}
                        </select>
                      </div>`;
    $('.append__prefecture').append(childSelectHtml);
  }

  function appendPrefecture(parentId) {
    if (parentId != ""){
      $.ajax({
        url: '/tweets/get_prefecture_children/',
        type: 'GET',
        data: { parent_id: parentId },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove();
        console.log(children)
        var insertHTML = '';
        var selectedValue = $('#prefecture_id_value').text();
        children.forEach(function(child){
          if (child.id == selectedValue) {
            insertHTML += appendSelectedOption(child);
          } else {
            insertHTML += appendOption(child);
          }
        });

        appendChildrenBox(insertHTML);
        if (insertHTML == "") {
          $('#children_wrapper').remove();
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    };
  }
  $('#item_prefecture_id').on('change', function() {
    var parentId = document.getElementById('item_prefecture_id').value;
    appendPrefecture(parentId);
  });

  if ($('#edit_prefectuure').text() == 'edit') {
    var parentId = document.getElementById('item_prefecture_id').value;
    appendPrefecture(parentId);
  }

});
});