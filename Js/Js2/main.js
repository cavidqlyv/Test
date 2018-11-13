// var message;
// var age =26;

// if(age>21){
//     message = "Bigger than 21";
//     console.log(message);
// }

// console.log([]);
// var username;
// while (true) {
//     username = prompt("Enter username", "");
//     if (username)
//         break;
// }

// console.log(username + "\nok!");

var num = 0;
console.log(parseInt(null));

num = prompt("Enter username", "");
// isNaN - eyer nandsa true
// parseInt("123asd") -> 123
// typeof 12 -> "number"

console.log(num);


if (typeof(parseInt(num)) != "number" || isNaN(parseInt(num)) == false) {
    console.log("Reqem deyil");
}
else {

    if (num > -100 && num < 100) {
        console.log("ok");
    }
    else {
        console.log("error");
    }
}