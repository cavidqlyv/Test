var str = prompt("Enter string");
//var res =  str[0].toUpperCase();
// var res = "";
// for (var index = str.length - 1; index >= 0; index--) {
//     res += str[index];
// }
var res;

if (str[0] === "$") {
    res = str.slice(1, str.length);
}
else {
    res = str;
}
console.log(parseInt(res));
