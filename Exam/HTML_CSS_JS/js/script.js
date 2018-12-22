var searchInput = document.getElementById("search-input");
searchInput.onfocus = function () {
    this.style.width = "150px";
    if (this.value == "Search")
        this.value = "";
}
searchInput.onblur = function () {
    this.style.width = "42px";
    if (this.value == "")
        this.value = "Search";
}
jQuery(document).ready(function () {
    if ($(window).width() >= 768) {
        $('.navbar ul').superfish();
    }

    function changeWiev() {

        if ($(window).width() < 768) {
            if (jQuery("#menu-mobile").length == 0) {

                jQuery('.menu .container').prepend('<a id="menu-mobile" href="javascript:void(0)" class="menu_toggler"><span class="fa fa-align-justify"></span></a>');
                jQuery('.navbar').hide();
                jQuery('.search').hide();

                jQuery('.menu_toggler, .navbar ul li a').click(function () {
                    jQuery('header .navbar').slideToggle(300);
                });
            }
        }
        else {
            jQuery("#menu-mobile").remove();
            jQuery('header .navbar').show();
            jQuery('.search').show();
        }
    };
    changeWiev();
     $(window).resize(changeWiev);
});
// $(window).load(function(){
// 	//Top Slider
	
// });
$(window).on('load',function () {
    	$('.flexslider.top_slider').flexslider({
    		animation: "fade",
    		controlNav: false,
    		directionNav: true,
    		animationLoop: false,
    		slideshow: false,
    		prevText: "",
    		nextText: "",
    		sync: "#carousel"
    	});
    	$('#carousel').flexslider({
    		animation: "fade",
    		controlNav: false,
    		animationLoop: false,
    		directionNav: false,
    		slideshow: false,
    		itemWidth: 100,
    		itemMargin: 5,
    		asNavFor: '.top_slider'
    	});
        
    	homeHeight();
        
        
    	jQuery('.flexslider.top_slider .flex-direction-nav').addClass('container');
        
        
    	//Vision Slider
    	$('.flexslider.portfolio_single_slider').flexslider({
    		animation: "fade",
    		controlNav: true,
    		directionNav: true,
    		animationLoop: false,
    		slideshow: false,
    	});
        

});
jQuery(window).resize(function(){
	homeHeight();
	
	
});

jQuery(document).ready(function(){
	homeHeight();
	
});

function homeHeight(){
	var wh = jQuery(window).height() - 80;
	jQuery('.top_slider, .top_slider .slides li').css('height', wh);
}
function calculateScroll() {
	var contentTop      =   [];
	var contentBottom   =   [];
	var winTop      =   $(window).scrollTop();
	var rangeTop    =   200;
	var rangeBottom =   500;
	$('.navmenu').find('.scroll_btn a').each(function(){
		contentTop.push( $( $(this).attr('href') ).offset().top );
		contentBottom.push( $( $(this).attr('href') ).offset().top + $( $(this).attr('href') ).height() );
	})
	$.each( contentTop, function(i){
		if ( winTop > contentTop[i] - rangeTop && winTop < contentBottom[i] - rangeBottom ){
			$('.navmenu li.scroll_btn')
			.removeClass('active')
			.eq(i).addClass('active');			
		}
	})
};