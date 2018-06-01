
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
      console.log(file);

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
    //ナビゲーションactive
    $('.alist').each(function() {
      var
        nowPath = location.pathname,
        link = $(this).find('a'),
        linkPath = link.attr('href');
      if ( nowPath == linkPath ) {
        link.addClass('active');  
      }
    });

    //sub-menuのactive化
    $('.alist-sub').each(function() {
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


//search-field　back-color可変
document.addEventListener('turbolinks:load', function() {
  $(function() {
    $('#keyword').focus(　function() {
      icon = $('.button-inner').find('.fa-search')
      icon.addClass('focus-on')
    }).blur( function() {
      icon.removeClass('focus-on')
    });
  });
});

// search順位best3 back-color変更
document.addEventListener('turbolinks:load', function() {
  $(function() {
    if( $('.rank').length != 0 ) {
      var
        best3 = $('.list').slice(0,3);
      for( var i = 0; i < 3; i++ ) {
        best3.eq(i).find('.active-count').addClass('rank-' + (i + 1));
      }
    }
  });
});

//textarea文字数カウンター
document.addEventListener('turbolinks:load', function() {
  $(function() {
    $('.char-count').on("change keydown keyup", function() {
      var
        textLength = $(this).val().length,
        $disable = $('.disabled'),
        $text = $("[id^=count-text]"),
        charLimit = $text.attr('id').match(/\d/g).join(""),
        zeroDisabled = ["60"];      //追加要素
      $('#count-' + charLimit).text(textLength);

      if ( zeroDisabled.indexOf(charLimit) >= 0 && textLength == 0 ) {
        $disable.prop('disabled', true);
        $text.text("1文字~" + charLimit + "文字まで入力できます");
      } else if ( textLength > Number(charLimit) ) {
        $disable.prop('disabled', true);
        $text.text("※入力できる文字数を超えています！");
      } else {
        $disable.prop('disabled', false);
        $text.text("1文字~" + charLimit + "文字まで入力できます");
      }

    });
  });
});

// profile内link
document.addEventListener('turbolinks:load', function() {
  $(function() {
    if ( $('#profile').length != 0 ) {
      var _url = $('#profile').text().match(/https:\/\/t.co\/\w{10}/g);

      if ( _url != null ) {
        for ( var i = 0; i < _url.length; i++ ) {
          var
            _profile = $('#profile').text(),
            replaceText = _profile.replace(new RegExp(_url[i], 'g'),
                                           "<a class='profile-link' href=" +
                                           escapeHtml(_url[i]) + ">" +
                                           escapeHtml(_url[i]) + "</a>");
          
          $('#profile').html(replaceText);
        }
      }
    }
  });
});

document.addEventListener('turbolinks:load', function() {
  $(function() {
    $('#active-dummy').on('click', function() {
      var
        $target = $('.active-dummy'),
        buttonToggle = $target.find('.button-slide'),
        buttonActive = $target.find('.button-active'),
        slideParts = $target.find('.slide');
      if ( buttonActive.length != 0 ) {
        buttonToggle.removeClass('button-active').addClass('button-passive');
        slideParts.removeClass('slide-off').addClass('slide-on');
      } else {
        buttonToggle.removeClass('button-passive').addClass('button-active');
        slideParts.removeClass('slide-on').addClass('slide-off');
      }
    });
  });
});

//未ログインアラートボタン
document.addEventListener('turbolinks:load', function() {
  $(function() {
    $('.ban').on('click', function() {
      alert('登録またはログインしてください！');

      if ($('#click-popup').length != 0) {
        $('#click-popup').slideDown();
      }
      return false;
    });
  });
});

// popup-login auto
document.addEventListener('turbolinks:load', function() {
  $(function() {
    if ( $('#auto-popup').length != 0 ) {
      setTimeout(function() {
        $('#auto-popup').slideDown();
      }, 10000);
    }
  });
});

document.addEventListener('turbolink:load', function() {
  $(function() {
    $("#lists").infiniteScroll({
      path: '.next a',
      append: '.list',
      button: '.button-more',
      scrollThreshold: false,
      status: '.list-load-status',
      history: false
    });
  });
});