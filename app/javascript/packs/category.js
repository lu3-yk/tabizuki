$(function(){
  console.log('hello')
  function appendOption(prefecture){
    var html = `<option value="${prefecture.id}">${prefecture.name}</option>`;
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

  $('#item_prefecture_id').on('change',function(){
    var parentId = document.getElementById('item_prefecture_id').value;
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
        children.forEach(function(child){
          insertHTML += appendOption(child);
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
  })
});