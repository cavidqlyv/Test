function filter(arr, func) {
    var res = [];
    var a;
    for (var item in arr) {
        a = func(arr[item]);
        if (a != undefined)
            res.push(func(arr[item]));
    }
    return res;
}

console.log(filter([1, 2, 3, 4, 5, 6, 7, 8], function (item) {
    if (item < 7)
        return item;
}));

function reduce(arr, func, start) {
    var res = start;
    for (var item in arr) {
        res = func(res, arr[item]);
    }
    return res;
}

var a = reduce([1, 2, 3, 4, 5, 6, 7], function (total, currentItem) { return total + currentItem }, 1);

console.log(a);