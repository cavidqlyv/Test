// document.getElementsByTagName("button")[0].onmouseover = function () {
//     console.log(this.getAttribute("data-tooltip"));
//     this.title = this.getAttribute("data-tooltip");
// }
// function isEmpty(obj) {
//     for (var key in obj) {
//         if (obj.hasOwnProperty(key))
//             return false;
//     }
//     return true;
// }

// var menu = {
//     Elektronika: {
//         "Mobil Telefonlar": {
//             hello: {}
//         },
//         "Audio": {}
//     },
//     Xidmetler: {
//         Seyahet: {
//             asdfg:{}
//         },
//         Eylence: {},
//         Reklam: {}
//     },
//     Neqliyyat: {
//         "Islenmis Aftomobiller": {},
//         "Ehtiyyat hisseleri ve aksessuarlar": {},
//         "Motosiklet": {},
//         "Diger": {}
//     }
// }

// function CreateMenu(menu) {
//     if (!isEmpty(menu)) {
//         var ul = document.createElement("ul");
//         for (var item in menu) {
//             var li = document.createElement("li");
//             var text = document.createTextNode(item);
//             var span = document.createElement("span");
//             span.appendChild(text);
//             li.appendChild(span);
//             if (CreateMenu(menu[item]) != null)
//                 li.appendChild(CreateMenu(menu[item]));
//             ul.appendChild(li);
//         }
//         return ul;
//     }
//     return null;
// }

// document.body.appendChild(CreateMenu(menu));

// $(document).ready(function () {
//     console.log("hello world");

// });

// $(document).click(function () {
//     alert("clicked");
// });


$("#myBtn").css("display: block;");

$("#myBtn").addClass("block");

