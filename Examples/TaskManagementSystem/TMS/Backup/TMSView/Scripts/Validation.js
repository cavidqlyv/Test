// JScript File
function CheckNumeric(cont) {  
    var upperRange = 57;
    var lowerRange = 48;
    var val = document.getElementById(cont).getAttribute("value");

    for (i = 0; i <= val.length - 1; i++) {
        if (val.charCodeAt(i) < lowerRange || val.charCodeAt(i) > upperRange) {
            return false;
        }
    }
    return true;
}