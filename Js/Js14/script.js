var elementsArray = document.querySelectorAll('li');

elementsArray.forEach(function (elem) {
    console.log(elem);
    elem.addEventListener("click", function () {
        if (elem.classList.contains("no-click"))
            return;
        var res = document.getElementsByClassName("change-background");
        console.log(res);

        for (var i = 0; i < res.length; i++) {
            console.log(res.classList);
            res[i].classList.toggle("change-background");
        }
        elem.classList.toggle("change-background");
    });
});