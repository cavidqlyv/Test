var leftButton = document.getElementsByClassName("left");
var rightButton = document.getElementsByClassName("right");

console.log(leftButton[0]);


leftButton[0].onclick = function () {
    var myGalleryItems = document.getElementsByClassName("my-gallery-items");
    console.log(myGalleryItems);
    
    myGalleryItems[0].style.left="500px";
}

rightButton[0].onclick = function () {
    var myGalleryItems = document.getElementsByClassName("my-gallery-items");
    console.log(myGalleryItems);
    
    myGalleryItems[0].style.left="500px";
}
// console.log(leftButton);


// leftButton.onmouseenter = function () {
//     this.style.width = "64px";
// }
