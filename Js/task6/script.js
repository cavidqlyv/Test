
function sum(params) {

    var sum1 = 0;
    var reducer = (accumulator, currentValue) => accumulator + currentValue;

    sum1 = Array.prototype.reduce.apply(arguments, [function (accumulator, currentValue) {
        return accumulator + currentValue;
    }, 0]);

    return sum1;
}


console.log(sum(1, 2, 3));