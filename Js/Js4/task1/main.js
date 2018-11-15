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

console.log(Split("alim , elnur , hesen , ", ""));