
//escape
function escapeHtml(string) {
  if (　typeof string !== 'string' ) {
    return string;
  }

  return string.replace(/[&'`"<>=\/]/g, function(match) {
    return {
      '&': '&amp;',
      "'": '&#x39;',
      '`': '&#x60;',
      '"': '&quot;',
      '/': '&#x2F;',
      '<': '&lt;',
      '>': '&gt;',
      '=': '&#x3D;'
    }[match]
  });
}

//flash表示非表示
document.addEventListener('turbolinks:load', function() {
  $(function(){
    if ( $("#flash").length != 0 ) {
      $('#flash').css('display', 'none').slideDown('fast');   //slideさせるために一旦非表示
      setTimeout( function(){
        $("#flash").slideUp('fast');
      }, 3000);
    }
  });
});

//画像ファイルプレビュー
document.addEventListener('turbolinks:load', function() {
  $(function() {
    //from内の該当要素を選択されたら(ファイルを選択しないときは発火しない)
    $('form').on('change', 'input[type="file"]', function(e) {
      var
        file = e.target.files[0],   //ファイルオブジェクト
        reader = new FileReader(),
        $preview = $('.preview'),
        $icon = $('.icon-upload');

      //実効終了条件
      if ( file == undefined || file.type.indexOf('image') < 0 ) {
        return false;
      }

      //読み込み成功して完了(onload)
      reader.onload = (function(file) {
        return function(e) {
          //preview挿入
          $preview.empty();
          $preview.append($('<img>').attr({
            src: e.target.result,
            class: "cover",
            size: 100,
            title: file.name
          }));
          //icon変更
          $icon.empty();
          setTimeout( function(){
            $icon.append($('<i>').attr('class', 'fa fa-refresh'));
            $icon.css('display', 'none').fadeIn('slow');
          }, 5000);
        };
      })(file);
      //ファイルをURLとして読み込む
      reader.readAsDataURL(file);
    });
  });
});

//現在位置active化
document.addEventListener('turbolinks:load', function() {
  $(function() {
    $('.alist').each(function() {
      var
        nowPath = location.pathname + location.search,
        link = $(this).find('a'),
        linkPath = link.attr('href');
      if ( nowPath == linkPath ) {
        link.addClass('active');  
      }
    });
  });
});


document.addEventListener('turbolinks:load', function() {
  $(function() {
    $("[id^=list-checkbox").on('click', function(e) {
      var
        str = $(this).attr("id"),
        num = str.match(/\d/g).join("");
      $('#edit_list_' + num).submit();
      setTimeout(function() {
        e.preventDefault();
        return false;
      }, 300);
    })
  });
});