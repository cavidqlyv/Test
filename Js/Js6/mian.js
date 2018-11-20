function fn(callback) {
 callback();   
}

function cb() {
    console.log("oj");
}

fn(cb);