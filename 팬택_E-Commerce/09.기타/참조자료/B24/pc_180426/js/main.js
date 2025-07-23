/* jQuery Start */
$(document).ready(function () {
	/* 메인 배너 */
	var mainBAnner = new Swiper('.swiper-container', {
		loop: true,
		pagination: {
			el: '.swiper-pagination',
			clickable: true,
		},
	});

	/* 메인 상품 탭 */
	$('.tab-list li').on({
		'click':function() {
			var idx = $(this).index();
			$('.tab-list li').removeClass('active');
			$(this).addClass('active');
			$('.tab-cont').hide();
			$('.tab-cont'+idx).fadeIn(1000);
		}
	});
});