// document.addEventListener("DOMContentLoaded", function () {
//     console.log("Dom is ok");
// })

// window.onload = function () {
//     console.log("ok");
// }


// class Animal {
//     constructor(name) {
//         this.name = name;
//     }
//     myName() {
//         console.log(this.name);
//     }
//     get name()
//     {
//         return this.name;
//     }
// }

// const human = new Animal("Human");

// human.myName();


let arr = [1, 2, 3, 4, 5, 6, 7];

for (let item of arr) {
    //console.log(item);
}


console.log(...arr);

console.log(Math.max(...arr));


function SomeFunction(a, b, ...rest) {
    console.log(a, b, rest);
}

const menuObject = {
    className : "main-menu",
    items : 7,
    description : "This is a good menu",
    galleryType:"masonry"
};

const {firstName:fn="Shafaq",lastName:lt="Abbasova"}=menuObject;

console.log(fn,lt);
