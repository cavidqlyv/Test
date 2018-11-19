var obj = {
};

obj.name = "asdfg";
obj.numOfStudents = 2000;
obj.numOfClasses = 30;
obj.ourClass = {
    "name": "FSDE",
    "teacherName": "Baxsi",
    "Students": ["Alim", "Zulfuqar", "Elnur", "Oktay"],
    "lessons": ["HTML", "CSS", "Js"]
}

//console.log(obj);

var car = { make: 'Honda', model: 'Accord', year: 1998 };

//console.log('make' in car);
// expected output: true

delete car.make;
if ('make' in car === false) {
    car.make = 'Suzuki';
}

//console.log(car.make);


//var obj = {a: 1, b: 2, c: 3};

for (const prop in obj) {
    //console.log(`obj.${prop} = ${obj[prop]}`);
}

function sum() {
    var sum = 0;
    // console.log(arguments);

    for (var i = 0; i < arguments.length; i++)
        sum += arguments[i];
    return sum;
}
//console.log(sum(1,2,5,6));

//func();

function repeatLog() {
    var res = "";
    for (var i = 0; i < arguments[arguments.length - 1]; i++) {
        for (var j = 0; j < arguments.length - 1; j++) {
            res += arguments[j];
        }
    }
    return res;
}

console.log(repeatLog("a", "l", "i", "m", " ", 5));
