//var str = prompt("Enter string");
//var res =  str[0].toUpperCase();
// var res = "";
// for (var index = str.length - 1; index >= 0; index--) {
//     res += str[index];
// }
// var res;

// if (str[0] === "$") {
//     res = str.slice(1, str.length);
// }
// else {
//     res = str;
// }
// console.log(parseInt(res));

// function name(a, b) {
//     return a + b;
// }

// console.log(name(1, 2));

// function trancate(str,num) {
//     var res = str.slice(0 , num);
//     return res;
// }

// var string = prompt("Enter String");
// var num = parseInt(prompt("Enter number"));

// console.log(trancate(string,num));

function checkSpam(str) {
    var res = str.toLowerCase();
    if (res.indexOf("dirol") != -1)
        return true;
    if (res.indexOf("twix") != -1)
        return true;
    if (res.indexOf("snickers") != -1)
        return true;
    return false;
}

console.log(checkSpam("ssnickers"));
console.log(checkSpam("TWIX haslhdkj"));
console.log(checkSpam("DirOl"));

console.log(checkSpam("ashgdjsa"));
