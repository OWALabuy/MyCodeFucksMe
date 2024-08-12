local person = {
    name = "OWALabuy",
    age = 13,
    height = 139,
    skill = {
        "cooking",
        "programming",
        "music",
    }
}
--以下这两条是完全等价的
print(person.name)
print(person["name"])

--语法糖可以与中括号同时使用
print(person.skill[2])
print(person["skill"][2])
