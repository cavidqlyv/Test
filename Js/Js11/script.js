// var promise = new Promise(function (resolve, reject) {
//     resolve("Hooray");
// });

// promise.then(function (response) {
//     console.log(response);
// }, function (reason) {
//     console.log(reason);
// })




var list = document.getElementsByClassName("red");

for (var i = 0; i < list.length; i++) {
    list[i].style.backgroundColor="red";
}

