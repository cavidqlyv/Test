function Join(a, b) {
    var size = a.length + a.length - 1;
    var res = "";
    for (var i = 0; i < a.length; i++) {
        res += a[i].toString();
        if (i != a.length - 1)
            res += b;
    }
    return res;
}

// console.log(Join([1, 2, 3, 4, 5], "$"));

function Split(a, b) {
    var tmp = "";
    var res = [];
    for (var i = 0; i < a.length; i++) {
        if (b == "") {
            res.push(a[i]);
        }
        else {
            if (a[i] != b)
                tmp += a[i];
            else {
                res.push(tmp);
                tmp = "";
            }
        }
    }
    return res;
}

//console.log(Split("alim , elnur , hesen , ", ""));

function deleteOnIndex(arr, index) {
    var res = [];
    if (index < 0)
        throw new Error("index error");
    if (index > arr.length)
        index = arr.length - 1;
    for (var i = 0; i < arr.length; i++) {
        if (i != index) {
            res.push(arr[i]);
        }
    }
    return res;
}

console.log(deleteOnIndex([1, 2, 3, 4], 10));

function addOnIndex(arr, index, item) {
    var res = [];
    if (index < 0)
        throw new Error("index error");
    if (index > arr.length)
        index = arr.length - 1;
    for (var i = 0; i < arr.length; i++) {
        if (i == index) {
            res.push(item);
        }
        res.push(arr[i]);
    }
    return res;
}

console.log(addOnIndex([1, 2, 3, 4], 1, 15));
