"use strict";

var carouselButtons = document.querySelectorAll('.carrosel-dentro ul li');

var _loop = function _loop(i) {
  carouselButtons[i].addEventListener('click', function () {
    $(document.querySelector('section').children[i]).slideToggle(300);
  });
};

for (var i = 0; i < carouselButtons.length; i++) {
  _loop(i);
}