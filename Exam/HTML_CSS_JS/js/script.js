var searchInput = document.getElementById("search-input");
console.log(searchInput);
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

    var width = $(window).width();
    $(window).on('resize', function () {
        if ($(this).width() != width) {
            width = $(this).width();
            console.log(width);
        }
    });

    function changeWiev() {
        "use strict";

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