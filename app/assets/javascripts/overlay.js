$(function() {
    // 「start」ボタンをクリック時に、fadeInメソッドでHTML要素を表示する
    $('#start').on('click', function() {
      $('#timer').fadeIn();
      $('#overlay').fadeOut();
    }
    );
    
    // 「stop」ボタンをクリック時に、fadeOutメソッドでHTML要素を非表示にする
    $('#stop').on('click', function() {
      $('#timer').fadeOut();
      $('#overlay').fadeIn();
    }
    )
  }
  );
  

  