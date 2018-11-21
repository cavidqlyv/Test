function makePow(p) {
    return function (n) {
        return Math.pow(n, p);
    }
}

var square = makePow(2);

console.log(square(5));


function makeCounter() {
    var counter = 0;
    return function (param) {
        if (param === true)
            counter = 0;
        else
            counter++;
        return counter;
    }
}

var counter = makeCounter();

console.log(counter());
console.log(counter());
console.log(counter());
console.log(counter(true));
console.log(counter());

