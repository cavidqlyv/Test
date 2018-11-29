// var promise = new Promise(function (resolve, reject) {
//     resolve("Hooray");
// });

// promise.then(function (response) {
//     console.log(response);
// }, function (reason) {
//     console.log(reason);
// })




// var list = document.getElementsByClassName("red");

// for (var i = 0; i < list.length; i++) {
//     list[i].style.backgroundColor="red";
// }


// function getFirstElementChild(elem) {
//     var firstChild = elem.firstChild;
//     while (firstChild.nodeType !== Node.ELEMENT_NODE) {
//         firstChild = firstChild.nextSibling;
//     }
//     return firstChild;
// }

// function getNextElementSibling(elem) {
//     var nextSibling = elem.nextSibling;
//     while (nextSibling.nodeType !== node.ELEMENT_NODE) {
//         nextSibling = nextSibling.nextSibling;
//     }
//     return nextSibling;
// }

// var crossElement = document.getElementsByClassName("Cross-table")[0];
// var firstChild = getFirstElementChild(crossElement);

// console.log(firstChild.rows);

// var time = 1000;
// setInterval(function () {
//     for (var i = 0; i < firstChild.rows.length; i++) {
//         firstChild.rows[i].getElementsByTagName("td")[i].style.backgroundColor = "red";
//         time += 1000;
//     }
// }, time);

// console.log(firstChild);


var a = document.getElementsByTagName("a")[0];
a.setAttribute("target", a.getAttribute("data-target"));

console.log(a);

var img  = document.getElementsByTagName("img")[0];

console.log(img.getAttribute("src"));
a.setAttribute("href", img.getAttribute("src"));

