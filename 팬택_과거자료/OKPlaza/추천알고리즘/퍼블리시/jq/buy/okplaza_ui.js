$(function(){
	$.fn.extend({
		// fn_gnb
		fn_gnb: function(options){
			var defaults = {};
			var opts = $.extend(defaults, options);
			return this.each(function(){
				var $header = $(this),
					$cate = $header.find('.allCate'),
					$nav = $cate.children('ul');

				var $btn = $cate.children('h2'),
					_allBtn = $('>a', $btn);

				_allBtn.bind('mouseenter focus',function(){
					$nav.show();
				});
				/*$cate.bind('mouseenter focus',function(){
					$('body').append('<div class="navDim"></div>');
				});*/
				$cate.bind('mouseleave blur',function(){
					if($header.hasClass('fixMenu')){
						//return
					}else{
						$nav.hide();
					}
					$('.navDim').remove();
				});

				var $navList = $nav.find('li'),
					_dep2 = $nav.children('li').children('ul');
					_dep3 = _dep2.children('li').children('ul');
				$navList.each(function(){
					var $this = $(this),
						$links = $('>a', $this);

					$links.bind('mouseenter focus',function(){
						var _list = $(this).parent();
						_list.addClass('hover').siblings().removeClass('hover');
						_list.children('ul').show();
						_list.siblings().children('ul').hide();
					});
					_dep2.bind('mouseleave blur',function(){
						_dep3.parent('li').removeClass('hover');
						_dep3.hide();
					});

					$nav.children().bind('mouseleave blur',function(){
						$navList.removeClass('hover');
						$navList.children('ul').hide();
					});
				});
			});
		}, // fn_gnb

		// fn_autoSlide
		fn_autoSlide : function(options) {
			var defaults = {
				delay: 3000,
				paging : false,
				auto : true,
				arrBtn : true,
				tabs: true,
				depth: false,
			}
			var opts = $.extend(defaults, options);
			return this.each(function() {
				var  $this = $(this),
					  $itemWrap = $this.find('.slider-items').children('ul'),
					  $items = $itemWrap.children('li'),
					  itemCount = $items.length,
					  itemsWidth = $items.width()*itemCount,
					  itemWidth = itemsWidth / itemCount,
					  sliderLoop,
					  activeIndex = 0,
					  delayTime = opts.delay,
					  auto = opts.auto,
					  arrBtn = opts.arrBtn,
					  tabs = opts.tabs,
					  depth = opts.depth,
					  paging = opts.paging;

				$itemWrap.width(itemsWidth);
				$items.eq(activeIndex).addClass("active");

				if($items.length < 1){
					if($this.hasClass('topBnr') || $this.parents().hasClass('ui-header')){
					}else{
						$this.remove();
					}
				}

				function sliderPlay(){
					sliderLoop = setInterval(function(){sliderContents()}, delayTime);
				}

				function sliderStop(){
					sliderLoop = clearInterval(sliderLoop);
				}

				var activeIdx = false;
				var tabAactiveIdx = false;
				function sliderContents(){
					$items.removeClass("active");
					if(auto){
						activeIndex++;

						if(arrBtn){
							$this.find('.prev').click(function(){
								activeIndex = $itemWrap.children('.active').index();
								sliderStop();
								sliderPlay();
							});

							$this.find('.next').click(function(){
								activeIndex = $itemWrap.children('.active').index();
								sliderStop();
								sliderPlay();
							});
						}

						if(tabs){
							$tabWrap.children('li').each(function(){
								$(this).children('button').click(function(){
									activeIndex = $itemWrap.children('.active').index();
									sliderStop();
									sliderPlay();
								});
							});
						}

						if(paging){
							$pagingWrap.children('li').each(function(){
								$(this).children('button').click(function(){
									activeIndex = $itemWrap.children('.active').index();
									sliderStop();
									sliderPlay();
								});
							});
						}
					}

					if(activeIndex == itemCount){
						activeIndex = 0;
						$itemWrap.stop().animate({'left':0});
					}
					$itemWrap.stop().animate({'left':-itemWidth*activeIndex});
					$items.eq(activeIndex).addClass("active");

					arrBtnCtrl.paging();
					arrBtnCtrl.tabPaging();
				}

				function bgChange(){
					if($this.hasClass('topBnr')){
						var $itemColor = $itemWrap.children('.active').attr('data-bgcolor');
						$this.css("background-color", "#"+$itemColor);
						$this.find('.toggle-ctrller').css("background-color", "#"+$itemColor);
					}
				}
				bgChange();

				var arrData = opts.tabData;

				// paging
				if(paging){
					var html = '<div class="slider-page"><ul>';
					for(i=1; i<=itemCount; i++){
						html += "<li><button type='button'>"+i+"페이지</button></li>";
					}
					html += "</ul></div>";
					$this.append(html);

					var $pagingWrap = $this.find('.slider-page').children('ul');
					$pagingWrap.children().first().addClass('on');

					$pagingWrap.children('li').each(function(){
						$(this).children('button').click(function(){
							sliderStop();

							var idx = $(this).parent().index(idx);
							$items.removeClass("active");
							$items.eq(idx).addClass("active");
							$itemWrap.stop().animate({'left':-itemWidth*idx});
							$pagingWrap.children('.on').removeClass('on');
							$(this).parent().addClass('on');

							arrBtnCtrl.tabPaging();
							activeIdx = true;
						});
					});
				}

				//tabs
				if(tabs){
					var html = '<div class="slider-tab"><ul>';
					$(arrData).each(function(idx){
						html += "<li>" + this.tabTit + "</li>";
					});
					html += "</ul></div>";
					$this.append(html);

					var $tabWrap = $this.find('.slider-tab').children('ul');
					$tabWrap.children('li').first().addClass('on');

					$tabWrap.children('li').each(function(){
						if($(this).text()=='undefined'){
							$(this).remove()
						}
						$(this).children('button').click(function(){
							sliderStop();

							var idx = $(this).parent().index();
							$items.removeClass("active");
							$items.eq(idx).addClass("active");
							$itemWrap.stop().animate({'left':-itemWidth*idx});
							$tabWrap.children('.on').removeClass('on');
							$(this).parent().addClass('on');

							arrBtnCtrl.paging();
							tabAactiveIdx = true;
						});
					});
				}

				// arrow
				if(arrBtn){
					$this.prepend('<button class="prev">이전</button>');
					$this.append('<button class="next">다음</button>');

					$this.find('.prev').click(function(){
						arrBtnCtrl.prevInt();
					});
					$this.find('.next').click(function(){
						arrBtnCtrl.nextInt();
					});
					if($items.length<=1){
						$this.find('.prev').remove();
						$this.find('.next').remove();
					}
				}

				var arrBtnCtrl = {
					prevInt: function(){
						sliderStop();

						if(activeIdx){
							var activeIndex = $this.find('.slider-page').children().children('.on').index()
						}else if(tabAactiveIdx){
							var activeIndex = $this.find('.slider-tab').children().children('.on').index()
						}else{
							var activeIndex = $itemWrap.children('.active').index();
						}

						$items.removeClass("active");
						$items.eq(activeIndex).prev().addClass('active');

						activeIndex--;
						if(activeIndex < 0){
							activeIndex = itemCount-1;
							$itemWrap.stop().animate({'left':0});
						}
						$itemWrap.stop().animate({'left':-itemWidth*activeIndex});
						$items.eq(activeIndex).addClass("active");

						bgChange();

						arrBtnCtrl.paging();
						arrBtnCtrl.tabPaging();
					},

					nextInt: function(){
						sliderStop();

						if(activeIdx){
							var activeIndex = $this.find('.slider-page').children().children('.on').index()
						}else if(tabAactiveIdx){
							var activeIndex = $this.find('.slider-tab').children().children('.on').index()
						}else{
							var activeIndex = $itemWrap.children('.active').index();
						}

						$items.removeClass("active");
						$items.eq(activeIndex).next().addClass('active');

						activeIndex++;
						if(activeIndex == itemCount){
							activeIndex = 0;
							$itemWrap.stop().animate({'left':0});
						}

						$itemWrap.stop().animate({'left':-itemWidth*activeIndex});
						$items.eq(activeIndex).addClass("active");

						bgChange();

						arrBtnCtrl.paging();
						arrBtnCtrl.tabPaging();
					},
					paging : function(){
						var $pagingWrap = $this.find('.slider-page').children('ul'),
							  activeIndex = $itemWrap.children('.active').index();

						$pagingWrap.each(function(){
							$pagingWrap.children('.on').removeClass('on');
							$pagingWrap.children().eq(activeIndex).addClass('on');
						});
					},
					tabPaging : function(){
						var $tabActive = $this.find('.slider-tab').children('ul'),
							  activeIndex = $itemWrap.children('.active').index();

						$tabActive.each(function(){
							$tabActive.children('.on').removeClass('on');
							$tabActive.children().eq(activeIndex).addClass('on');
						});
					}
				}

				if($this.hasClass('banRolling')){
					if(itemCount<=1){
						$this.find('.slider-page').remove();
						$this.find('>button').remove();
					}
				}

				// autoplay
				if(auto){
					sliderPlay()
				}else{
					sliderContents();
				}

			});
		}, // fn_autoSlide

		// fn_prodRoll
		fn_prodRoll: function(options){
			var defaults = {
				auto:true,
				arrow : {
					hoverShow : true,
				},
				item :7
			};
			var opts = $.extend(defaults, options);
			return this.each(function(){
				var $this = $(this),
					$items = $('.prod-grid-comp',$this),
					$item = $('.product-list',$this),
					_auto = opts.auto,
					_arrow = opts.arrow,
					_item = opts.item,
					_count,
					interval;

				if($this.hasClass('t-auto')) $items.width(($item.width()+40)*$item.length).css({'left':'50%','margin-left':-$items.width()/2-20});

				function prodMove(){
					clearInterval(interval);
					interval = setInterval(function(){
						_count ++;
						_first = $items.children('.product-list');
						$items.children().first().stop().animate({'margin-left':'-245px'}, function(){
							$items.append(_first[0]);
							$items.children().last().css({'margin-left':'40px'});
						});
					},3000);
				}

				function prodPrev(){
					_last = $items.children('.product-list').last();
					$items.prepend(_last);
				}

				function prodNext(e){
					_first = $items.children('.product-list').first();
					$items.append(_first);
				}

				var _prev = $('<a href="javascript:;" class="prod-arr prod-prev">이전</a>'),
					  _next = $('<a href="javascript:;" class="prod-arr prod-next">다음</a>');

				if($this.hasClass('t-auto')){
					if($item.length>=_item-1){
						$this.prepend(_prev);
						$this.append(_next);
						var _arrBtn = $this.find('.prod-arr');
						if(_arrow.hoverShow) _arrBtn.hide();
						else _arrBtn.show();
					}
				}else{
					if($item.length>_item){
						$this.prepend(_prev);
						$this.append(_next);
						var _arrBtn = $this.find('.prod-arr');
						if(_arrow.hoverShow) _arrBtn.hide();
						else _arrBtn.show();
					}
				}
				_prev.click(prodPrev);
				_next.click(prodNext);

				$this.bind('mouseenter', function(){
					if(_arrow.hoverShow){ _arrBtn.fadeIn()}
					clearInterval(interval);
				});
				$this.bind('mouseleave', function(){
					if(_arrow.hoverShow) _arrBtn.fadeOut();
					if(_auto){if($item.length>=_item) prodMove()};
				});

				if(_auto){
					if($item.length>=_item) prodMove();
				}
				return true;
			});
			
		}, // fn_prodRoll

		fn_rollingCtrl : function(options) {
			var defaults = {
				slideLen:1,
				view:1,
				marginLeft:0,
				marginTop:0,
				line:1,
				horizen : false
			};
			var opts = $.extend(defaults, options);
			return this.each(function() {
				var $this = $(this),
					  $items = $this.children('ul'),
					  $item = $items.children('li'),
					  activeIndex = 0,
					  itemsLen = $item.length,
					  itemWid = $item.width(),
					  itemHei = $item.height(),
					  marginLeft = opts.marginLeft,
					  marginTop = opts.marginTop,
					  itemsWidth = (itemWid+marginLeft) * itemsLen,
					  itemsHeight = (itemHei+marginTop) * itemsLen,
					  slideLen = opts.slideLen,
					  view = opts.view,
					  horizen = opts.horizen,
					  line = opts.line;

				$items.wrap('<div class="rolling-wrap"></div>');

				if(horizen){
					$this.find('.rolling-wrap').height((itemHei+marginTop)*line);
					var horLen = itemsLen % slideLen; 
					if(horLen == 0){
						var horLen2 = itemsLen / slideLen;
						$items.height(((itemHei+marginTop)*line)*horLen2);
					}else{
						var horLen2 = itemsLen / slideLen + 1;
						$items.height(((itemHei+marginTop)*line)*horLen2);
					}
					$items.css({'margin-top':0});
				}else{
					$this.find('.rolling-wrap').width((itemWid+marginLeft)*view);
					$items.width(itemsWidth);
					$items.css({'margin-left':0});
				}

				if(view < $items.children().length){
					$this.find('.ctrller').remove();
					$this.prepend('<button type="button" class="prev ctrller">이전</button>');
					$this.append('<button type="button" class="next ctrller">다음</button>');
					if($this.hasClass('product-wrap') || $this.hasClass('dealList') || $this.hasClass('bestReviewWrap') || $this.hasClass('mmrolling')){
						$this.find('.ctrller').hide();
					}
				}else{
					$this.find('.ctrller').remove();
				}

				if($this.hasClass('product-wrap') || $this.hasClass('dealList') || $this.hasClass('bestReviewWrap') || $this.hasClass('mmrolling')){
					$this.bind('mousemove', function(){
						if($this.find('.ctrller').is(":hidden")){
							$this.find('.ctrller').fadeIn();
						}
					});
					$this.bind('mouseenter', function(){
						$this.find('.ctrller').fadeIn();
					})
					$this.bind('mouseleave', function(){
						$this.find('.ctrller').fadeOut()
					})
				}

				var ulWid = (itemWid+marginLeft)*slideLen,
					  ulHei = (itemHei+marginTop)*line,
					  idx2 = parseInt(itemsLen % slideLen),
					  idx = parseInt(itemsLen / slideLen);

				var rollingBtn = {
					prev: function(){
						activeIndex--;
						if(activeIndex<0){
							if(idx2 == 1){
								activeIndex = idx
							}else{
								activeIndex = idx;
								if(idx2==0){
									activeIndex = idx-1;
								}else if(idx2<2 && idx2==2){
									activeIndex = idx;
								}
							}
							if(horizen){
								$items.css({'margin-top':0});
							}else{
								$items.css({'margin-left':0});
							}
						}
						if(horizen){
							$items.css({'margin-top':0});
						}else{
							$items.css({'margin-left':0});
						}

						$items.children().removeClass('on');
						if(horizen){
							$items.css({'margin-top':-ulHei*activeIndex});
						}else{
							$items.css({'margin-left':-ulWid*activeIndex});
						}
					},

					next: function(){
						activeIndex++;
						if(activeIndex > 0){
							if(idx2 == 0){
								if(activeIndex > idx-1){
										activeIndex=0;
								}
							}
							if(activeIndex > idx){
								activeIndex=0;
							}

							if(horizen){
								$items.css({'margin-top':0});
							}else{
								$items.css({'margin-left':0});
							}

						}
						if(horizen){
							$items.css({'margin-top':0});
						}else{
							$items.css({'margin-left':0});
						}

						$items.children().removeClass('on');
						if(horizen){
							$items.css({'margin-top':-ulHei*activeIndex});
						}else{
							$items.css({'margin-left':-ulWid*activeIndex});
						}
					},
				}

				$this.find('.prev').click(function(){
					rollingBtn.prev();
					$("span[id*='select']").click(function() {
						$("span[id*='select']").removeClass('selected');
						$(this).addClass('selected');
					});
				});
				$this.find('.next').click(function(){
					rollingBtn.next()
				});
			});
		}, // fn_controller

		// fn_dialog
		fn_dialog : function(options) {
			var defaults = {
				modal: true,
				fluid: true
			}
			var opts = $.extend(defaults, options);
			return this.each(function() {
				var $btn = $(this),
					target = $btn.data("href");

				if(target === undefined || $.trim(target) == "") return;

				if($btn.hasClass("dialog_disabled")) return;
				$btn.addClass("dialog_disabled");

				if(target.substr(0,1) != "#") {
					ajaxLoad("GET", target);
				} else {
					var $target = $(target);
					if($target.prop("tagName").toLowerCase() == "form") {
						if($target.attr("method") !== undefined) ajaxType = $target.attr("method");
						if($target.attr("action") !== undefined) ajaxURL = $target.attr("action");
						ajaxData = $target.serialize();

						ajaxLoad(ajaxType, ajaxURL, ajaxData);
					} else {
						var $content = $(".dialog_content", $target);
						openDialog($target, $content, true);
					}
				}

				function ajaxLoad(_type, _url, _data) {
					$.ajax({
						dataType: "html",
						type: _type,
						url: _url,
						data: _data,
						success: function(htmldata) {
							$wrap = $('<div class="my_dialog_wrap"></div>').appendTo("body");
							$wrap.append(htmldata);
							$content = $(".dialog_content", $wrap);
							openDialog($wrap, $content);
						},
						error: function() {
							alert("error!!");
						},
						cache: false
					});
				}

				function openDialog(_wrap, _content, inline) {
					var pos = $btn.data("position");
					if(pos !== undefined) {
						opts.modal = false;
						opts.fluid = false;
						opts.position = {
							my: pos + ' top',
							at: pos + ' bottom',
							of: $btn
						}
					}

					_content.dialog({
						width: _content.width(),
						modal: opts.modal,
						fluid: opts.fluid,
						position: opts.position,
						draggable: false,
						close: function() {
							$(this).dialog("destroy").remove();
							$btn.removeClass("dialog_disabled");
							if(inline) {
								_wrap.append(_content);
							} else {
								_wrap.remove();
							}
						},
						open: function() {
							$(this).parent().focus();
						}
					});

				}
			});
		},

		// fn_datepicker
		fn_datepicker : function(options) {
			var defaults = {};
			var opts = $.extend(defaults, options);
			return this.each(function() {
				var $this = $(this),
					btnImg = $this.attr("data-button"),
					range = $this.attr("data-range"),
					from = $this.attr("data-from"),
					to = $this.attr("data-to"),
					minDate, maxDate, $elm, optDate,
					enableDates = opts.enableDates,
					onSelect = opts.onSelect;

				var dateOptions = {
					showOtherMonths: true,
					selectOtherMonths: true,
					dateFormat: 'yy-mm-dd'
				}

				if(range !== undefined && $.trim(range) != "") {
					var arrRange = range.split(",")
					dateOptions.minDate = $.trim(arrRange[0]);
					dateOptions.maxDate = $.trim(arrRange[1]);
				}

				if(btnImg === undefined || !btnImg) {
					dateOptions.showOn = "both";
					//dateOptions.buttonImage = "/resources/main/image/datepicker.png";
					//dateOptions.buttonImageOnly = true;
				}

				if(to !== undefined && $.trim(to) != "") {
					$elm = $(to);
					optDate = "minDate";
				}
				if(from !== undefined && $.trim(from) != "") {
					$elm = $(from);
					optDate = "maxDate";
				}
				if($elm !== undefined) {
					dateOptions.onClose = function(selectedDate) {
						$elm.datepicker("option", optDate, selectedDate);
					}
				}

				if(enableDates !== undefined) {
					dateOptions.beforeShowDay = function(d) {
						var dmy = d.getMonth() + 1;
						if(d.getMonth() < 9) dmy = "0" + dmy;
						dmy += "-";

						if(d.getDate() < 10) dmy += "0";
						dmy = d.getFullYear() + "-" + dmy + d.getDate();

						if($.inArray(dmy, enableDates) != -1) {
							return [true, "ui-datepicker-current-day"];
						} else {
							return [false, ""];
						}
					}
				}

				if(onSelect !== undefined) {
					dateOptions.onSelect = onSelect;
				}

				$.datepicker.regional['ko'] = {
					closeText: '닫기',
					prevText: '이전달',
					nextText: '다음달',
					currentText: '오늘',
					monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					dayNames: ['일','월','화','수','목','금','토'],
					dayNamesShort: ['일','월','화','수','목','금','토'],
					dayNamesMin: ['일','월','화','수','목','금','토'],
					weekHeader: 'Wk',
					dateFormat: 'yy-mm-dd',
					firstDay: 0,
					isRTL: false,
					showMonthAfterYear: true,
					yearSuffix: '년'};

				$.datepicker.setDefaults($.datepicker.regional['ko']);
				$this.datepicker(dateOptions);
			});
		}, // fn_datepicker

		// tooltip
		fn_tooltip : function(options) {
			var defaults = {};
			var opts = $.extend(defaults, options);
			return this.each(function() {
				var $this = $(this);
				$this.tooltip({
					items: "[data-html], [data-ajax], [title]",
					content: function(callback) {
						var $elm = $(this);
						if($elm.is("[data-html]")) {
							return $elm.find(".tooltip_content").html();
						}
						if($elm.is("[data-ajax]")) {
							var url = $elm.data("ajax");
							$.get(url, function(data) {
								if(typeof data.data != 'undefined') {
									callback(data.data);
								} else {
									callback(data);
								}
							});
						}
						if($elm.is("[title]")) {
							return $elm.attr("title");
						}
					},
					position: {
						my: "center bottom-10",
						at: "center top",
						using: function(position, feedback) {
							$(this).css(position);
							$("<div>").addClass("tooltip_arrow").addClass(feedback.vertical).addClass(feedback.horizontal).appendTo(this);
						}
					},
					disabled: true
				}).click(function(e) {
					$this.tooltip("option", "disabled") ? openTooltip() : closeTooltip();
					e.preventDefault();
				}).hover(openTooltip, closeTooltip);

				function openTooltip() {
					$this.tooltip("option", {disabled: false}).tooltip("open");
				}

				function closeTooltip() {
					$this.tooltip("option", {disabled: true}).tooltip("close");
				}
			});
		}, // fn_tooltip

		//fn_tabs
		fn_tabs: function(options){
			var defaults = {};
			var opts = $.extend(defaults, options);
			return this.each(function(){
				var $this = $(this),
					$tabList = $this.children(),
					$panel = $this.parent().find('.tabs-panel').children('.panel-section'),
					$current = $this.children('.current').index();

				if($this.find('.tabs-panel')){
					$panel.eq($current).show();
				}

				$tabList.each(function(){
					if($(this).hasClass('current')){
						$(this).prev().addClass('none');
					}
				
					$(this).children().click(function(){
						if($this.parent().hasClass('no-script')){
							// no script
						}else{
							$(this).parent().addClass('current').siblings().removeClass('current');
							if($(this).parent().hasClass('current')){
								$tabList.removeClass('none');
								$(this).parent().prev().addClass('none');
							}

							// 탭 컨텐츠 있을경우
							if($this.find('.tabs-panel')){
								var $tabIdx = $(this).parent().index();
								$panel.hide().eq($tabIdx).show();
							}
						}
					});
				});
			});
		}, // fn_tabs
	});


	/* fn 선언 */
	// tab
	$('.ok_header').fn_gnb();

	// datepicker
	$(".js_datepicker").fn_datepicker();

	// main :: 대배너
	$('.autoRolling .rolling-ctrl').find('.control-area').wrap('<div class="slider-items"></div>');
	$('.autoRolling .rolling-ctrl').fn_autoSlide({
		auto:true,
		arrBtn:true,
		paging:false,
		tabs:false,
		depth:false,
		tabData : false,
	});

	// 메인 추천상품
	$('.mainRollBox .rotating-prod').fn_prodRoll({
		auto:false,
		arrow :{
			hoverShow : false,
		},
		item :5
	});
	// 상품검색 :: 연관상품 :: 수동
	$('.rotating-prod.connect-prod').fn_prodRoll({
		auto:false,
		arrow :{
			hoverShow : false,
		},
		item :4
	});
	// 장바구니 연관상품 :: 수동
	$('.subBoxWrap .rotating-prod').fn_prodRoll({
		auto:false,
		arrow :{
			hoverShow : false,
		},
		item :5
	});

	// 상품상세 :: 레이어팝업
	$(".js_dialog").click(function(e) {
		$(this).fn_dialog();
		e.preventDefault();
	});

	// quick menu rolling
	$('.quickRoll .rolling-ctrl').fn_rollingCtrl({
		slideLen : 1,
		view : 1,
		marginLeft:3,
	});

	// quick menu rolling tooltip
	$('.quickRoll .control-area li').each(function(){
		$(this).children().mouseenter(function(){
			$(this).next('.prod-info').show();
		});
		$(this).children().mouseout(function(){
			$(this).next('.prod-info').hide();
		});
	});

	// go top
	$('.goTop').click(function(){
		$(window).scrollTop(0);
	});

	// tab
	$('.tabs-comp > ul').fn_tabs();
});

/* main notice */
$(document).ready(function(){
	var height =  $(".notice").height();
	var num = $(".noticeRoll li").length;
	var max = height * num;
	var move = 0;
	function noticeRolling(){
		move += height;
		$(".noticeRoll").animate({"top":-move},600,function(){
			if( move >= max ){
				$(this).css("top",0);
				move = 0;
			};
		});
	};
	noticeRollingOff = setInterval(noticeRolling,3000);
	$(".noticeRoll").append($(".noticeRoll li").first().clone());


	$('.flexBtn').click(function(){
		if($(this).children('.fa').hasClass('fa-chevron-circle-right')) $(this).children('.fa').removeClass('fa-chevron-circle-right').addClass('fa-chevron-circle-left');
		else $(this).children('.fa').removeClass('fa-chevron-circle-left').addClass('fa-chevron-circle-right')

		if($(this).parent('th').attr('colspan')==4) $(this).parent('th').attr('colspan','1');
		else $(this).parent('th').attr('colspan','4');

		$(this).parents('.scrollTable').toggleClass('extend');
	});

	$("ul.menu > li").on('mouseover', function(){
		$(this).find('a').addClass('hover');
		$(this).find('ul.sub-list').show();
	}).on('mouseout',function(){
		$(this).find('a').removeClass('hover');
		$(this).find('ul.sub-list').hide();
	});
});


/* common :: nav */
$(function(){
	var $gnb = $('.gnb'),
		$gnbList = $('> ul > li', $gnb),
	_dep2 = $gnb.children('.gnbAll');
	
	$gnbList.bind('mouseenter focus',function(){
		_dep2.show();
	});
	$gnb.bind('mouseleave blur',function(){
		_dep2.hide();
	});
});
