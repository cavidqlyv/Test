//#region Search input

(function () {
    var searchInput = document.getElementById("search-input");
    console.log(searchInput);
    searchInput.onfocus = function () {
        this.style.width = "100px";
        if (this.value == "Search")
        this.value = "";
    }
    searchInput.onblur = function () {
        this.style.width = "42px"; 
        if (this.value == "")
        this.value = "Search";
    }
}())


//#endregion
