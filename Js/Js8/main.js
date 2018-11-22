// var obj = {
//     Name: "asdfg",
//     Surname : "qwerty",
//     getFullName:function (params) {

//     }
// }

var user = {
    Name: "Alim",
    Surname: "Salehzade",
    Age: 15,
    SetAge: function (_age) {
        this.Age = _age;
    }
}

//console.log(user.Age);

user.SetAge(21);
//console.log(user.Age);

var calculator = {
    num1: 0,
    num2: 0,
    read: function () {
        this.num1 = parseInt(prompt("Enter number"));
        this.num2 = parseInt(prompt("Enter number"));
        var cmd = prompt("Enter command");
        if (cmd == "sum")
            alert(this.num1 + this.num2);
        else if (cmd = "mul")
            alert(this.num1 * this.num2);
        else
            alert("error");

    },
    sum: function () {
        return this.num1 + this.num2;
    },
    multiply: function () {
        return this.num1 * this.num2;
    }
}

//calculator.read();
//console.log(calculator.sum());
//console.log(calculator.multiply());

var pilleken = {
    value: 0,
    up: function () {
        this.value++;
        return this;
    },
    down: function () {
        this.value--
        return this;
    },
    show: function () {
        console.log(this.value);
        return this;
    }
}
pilleken.up().down().show();
