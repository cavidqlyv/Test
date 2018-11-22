// var obj = {
//     Name: "asdfg",
//     Surname : "qwerty",
//     getFullName:function (params) {
        
//     }
// }

var user = {
    "Name" :"Alim",
    "Surname":"Salehzade",
    "Age":15,
    "SetAge":function (_age) {
        this.Age=_age;
    }
}

console.log(user.Age);

user.SetAge(21);
console.log(user.Age);
