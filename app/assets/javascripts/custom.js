
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