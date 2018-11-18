console.log("Reverse :");

function reverse(arr) {
    if (Array.isArray(arr) == false) {
        console.error("Error");
    }
    var res = [];
    for (var i = arr.length - 1, j = 0; i >= 0; i-- , j++) {
        res[j] = arr[i];
    }
    return res;
}

console.log(reverse([1, 2, 3, 4, 5]));
console.log(reverse(['Shafaq', 'Oqtay', 'Zulfuqar', 'Cavid', 'Alim']));

/*=======================================================================*/

console.log("Sort:");

function sort(arr, isDesc = false) {
    //var res = [];
    parse

    var length = arr.length;
    if (isDesc == false) {
        for (var i = 0; i < length; i++) {
            for (var j = 0; j < (length - i - 1); j++) {
                if (arr[j] > arr[j + 1]) {

                    var tmp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = tmp;
                }
            }
        }
    }
    else {
        for (var i = 0; i < length; i++) {
            for (var j = 0; j < (length - i - 1); j++) {
                if (arr[j] < arr[j + 1]) {

                    var tmp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = tmp;
                }
            }
        }
    }
    return arr;
}

console.log(sort([1, 5, 4, 3, 2], true));
console.log(sort(['Shafaq', 'Oqtay', 'Zulfuqar', 'Cavid', 'Alim']));
