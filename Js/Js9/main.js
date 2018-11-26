function Constructor(name,surname,age) {
    this.name = name;
    this.surname = surname;
    this.age = age;
    this.GetFullName = function () {
        return name +" " + surname;
    }
}

var a = new Constructor("Alim" , "Salehzade" , 21);

console.log(a.GetFullName());
