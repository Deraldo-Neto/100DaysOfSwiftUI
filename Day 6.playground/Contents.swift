//FOR:
let platforms = ["iOS", "macOS", "tvOS", "WatchOS"]

//os É O LOOP VARIABLE
for os in platforms { //LOOP ITERATION
    print("Swift works great on \(os).") //LOOP BODY
}


//Se eu digito por exemplo, for plat.. o swift já entende que platforms está no plural e faz toda a interação

//1...12 é o range, isso significa que todos os numeros, inclusive os 1 e os 12, vão cubrir o range
for i in 1...12 {
    print("The \(i) times table")
    
    //NEST LOOP
    for j in 1...12 {
        print(" \(j) x \(i) is \(j * i)")
    }
    print() //PULA UMA LINHA
}

//Vai do 1 ao 5
for i in 1...5 {
    print("Counting from 1 through 5: \(i)")
}

//Vai do 1 ao 4
for i in 1..<5 {
    print("Couting from 1 up to 5: \(i)")
}

//Também tem como eu não me importar com o loop, pq ele não vai ser útil, por exemplo:
var lyric = "Haters gonna"

for _ in 1...5 {
    lyric += "hate"
}
//isso é mais útil ainda em pensar que caso vc tenha um array chamado names, caso vc coloque a variável name por exemplo, ele vai pegar o elemento do array names e colocar em name, isso agiliza o processo então

//Eu consigo falar pro Swift ir do início de um array até o fim dele, usando 0...

//WHILE:
//Menos comum, menos útil e menos usado
var countdown = 10

while countdown > 0 {
    print("\(countdown)...")
    countdown -= 1
}

print ("Blast off!")

//Ele é util quando vc não sabe por quanto tempo o loop vai ser rodado, veja um exemplo:

//RANDOM INT
let id = Int.random(in: 1...10000)
let amount = Double.random(in: 0...1)


var roll = 0
while roll != 20 {
    roll = Int.random(in: 1...20)
    print("I ROLLED A \(roll)")
}

print("Critical Hit!")

//SKIP LOOP:
//BREAK E CONTINUE
//O CONTINUE pula uma iteração
let filenames = ["me.jpg", "work.txr", "sophie.jpg"]

for filename in filenames {
    if filename.hasSuffix(".jpg") == false {
        continue
    }
    
    print("Found picture: \(filename)")
}

//O BREAK pula fora do for
let number1 = 4
let number2 = 14
var multiple = [Int]()

for i in 1...100_000 {
    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiple.append(i)
        if multiple.count == 10 {
            break
        }
    }
}
print(multiple)


//CHECKPOINT 3
//Your goal
for i in 1...100 {
    if i.isMultiple(of: 3) && i.isMultiple(of: 5) {
        print("FizzBuzz")
    } else if i.isMultiple(of: 5) {
        print("Buzz")
    } else if i.isMultiple(of: 3) {
        print("Fizz")
    } else {
        print("\(i)")
    }
}
