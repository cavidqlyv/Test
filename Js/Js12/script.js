// console.log(document.querySelector("ul [class^=item-]"));
// console.log(document.querySelectorAll("ul [class^=item-]"));

// var ul = document.createElement("ul");

// for (var i = 1; i < 9; i++) {
//     var li = document.createElement("li");
//     li.classList.add("item-" + i);
//     li.appendChild(document.createTextNode("item-" + i));
//     ul.appendChild(li);
// }


// document.body.appendChild(ul);

// function createList(options) {
//     if (typeof (options.callback) != "function")
//         throw new Error("callback is not function")
//     if (options.items == undefined)
//         options.items = 5;
// var ul = document.createElement("ul");

//     for (var i = 0; i < options.items; i++) {
//         var li = document.createElement("li");
//         options.callback(li);
//         ul.appendChild(li);
//     }
// }

// var ul = createList({
//     items: 2,
//     callback: function (li) {
//         //console.log(params);
//         li.appendChild(document.createTextNode("item"));
//     }
// })
// document.body.appendChild(ul);

function Add(row, type, data) {

    if (type == "th") {
        var th = document.createElement("th");
        var text = document.createTextNode(data);
        th.appendChild(text);
        row.appendChild(th);
    }
    else if (type == "td") {
        var td = document.createElement("td");
        var text = document.createTextNode(data);
        td.appendChild(text);
        row.appendChild(td);
    }
}

var table = document.createElement("table");
var tr = document.createElement("tr");

Add(tr , "th" , "b.e");
Add(tr , "th" , "ch.a");
Add(tr , "th" , "ch");
Add(tr , "th" , "c.a");
Add(tr , "th" , "c");
Add(tr , "th" , "sh");
Add(tr , "th" , "b");

table.appendChild(tr);

document.body.appendChild(table);

for (var i = 0; i < 31; i++) {

}