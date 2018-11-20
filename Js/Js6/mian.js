function fn(callback) {
    callback();
}

function cb() {
    console.log("oj");
}

fn(cb);

function print(item) {
    return item * 2;
}

function repeat(arr, callback) {
    var res = [];
    for (item in arr) {
        res[item] = callback(arr[item]);
    }
    return res;
}
console.log(repeat([1, 2, 3, 4], print));