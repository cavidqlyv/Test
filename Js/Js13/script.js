// var span = document.createElement("span");

// span.innerHTML = "Hello World!";

// document.body.appendChild(span);
// document.body.removeChild(span);
// document.body.appendChild(span);
var myButton = document.querySelector(".my-button");

var myInput = document.querySelector(".my-input")

var ul = document.createElement("ul");

document.body.appendChild(ul);

myButton.onclick = function () {
    var li = document.createElement("li");
    li.classList.add("item");
    li.appendChild(document.createTextNode(myInput.value));
    li.onclick=function () {
        li.style.textDecoration = "line-through";
    }
    ul.appendChild(li);
};