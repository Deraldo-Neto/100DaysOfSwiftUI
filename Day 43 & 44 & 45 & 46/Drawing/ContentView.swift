//
//  ContentView.swift
//  Drawing
//
//  Created by Deraldo on 18/08/22.
//

import SwiftUI

//Paths vs shapes in SwiftUI
//struct Triangle: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        //minX é o menor valor para X no nosso triangulo, e o max é o maior valor para X no nosso triangulo
//        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
//
//        return path
//    }
//}

//struct Arc: InsettableShape { //alterei de Shape para InsettableShape
    //let startAngle: Angle
    //let endAngle: Angle
    //let clockwise: Bool
    //Adding strokeBorder() support with InsettableShape
    //var insetAmount = 0.0
    
    //func path(in rect: CGRect) -> Path {
        //essas propriedades são para corrigir um problema: 0 graus no SwiftUI, não é pra cima, e sim o canto direito, e as formas medem suas coordenadas a partir do canto inferior esquerdo, e não do canto superior esquerdo, então o SwiftUI faz o contrário de um ângulo para o outro.
        //let rotationAdjustment = Angle.degrees(90)
        //let modifiedStart = startAngle - rotationAdjustment
        //let modifiedEnd = endAngle - rotationAdjustment
        //
        //var path = Path()
        
        //path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: //modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise) //Como aqui, quado eu quero reduzir o arco para caber na tela, é interessante colocar o insetAmount dentro do radius.
        
//        return path
//    }
    
    //Adding strokeBorder() support with InsettableShape
//    func inset(by amount: CGFloat) -> some InsettableShape { //Essa função serve para colocar o insettableShape. CGFloat é uma maneira arcaica de se usar o Double
//        var arc = self
//        arc.insetAmount += amount
//        return arc
//    }
//
//}





//Transforming shapes using CGAffineTransform and even-odd fills
//struct Flower: Shape { //criando uma flor de forma manual
//    var petalOffset = -20.0
//    var petalWidth = 100.0
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
//            let rotation = CGAffineTransform(rotationAngle: number)
//            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
//
//            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
//            let rotatedPetal = originalPetal.applying(position)
//
//            path.addPath(rotatedPetal)
//
//        }
//        return path
//    }
//}





//Enabling high-performance Metal rendering with drawingGroup()
//struct ColorCyclingCircle: View {
//    var amount = 0.0
//    var steps = 100
//
//    var body: some View {
//        ZStack {
//            ForEach(0..<steps) { value in
//                Circle()
//                    .inset(by: Double(value))
//                    .strokeBorder(
//                        LinearGradient(
//                            gradient: Gradient(colors: [
//                                color(for: value, brightness: 1),
//                                color(for: value, brightness: 0.5),
//                            ]), //vai colocar uma cor mais clara no topo e mais escura no centro
//                            startPoint: .top,
//                            endPoint: .bottom
//                        ),
//                        //color(for: value, brightness: 1),
//                        lineWidth: 2
//                    )
//            }
//        }
//        .drawingGroup() //Isso faz com que o código rode MUITO mais rápido por que ele utiliza o GPU. Lembre-se: Tente sempre optimizar seu código antes de usar esse modificador.
//    }
//
//    func color( for value: Int, brightness: Double) -> Color {
//        var targetHue = Double(value) / Double(steps) + amount
//
//        if targetHue > 1 {
//            targetHue -= 1
//        }
//
//        return Color(hue: targetHue, saturation: 1, brightness: brightness)
//    }
//}








//Animating simple shapes with animatableData
//struct Trapezoid: Shape {
//    var insetAmount: Double
//
//    //Código para fazer  trapezoid ser animado
//    var animatableData: Double {
//        get { insetAmount }
//        set { insetAmount = newValue } //O que acontece aqui é que ele vai interpolando os valores até o valor que foi definido
//    }
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        path.move(to: CGPoint(x: 0, y: rect.maxY))
//        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
//
//        return path
//    }
//}







//Animating complex shapes with AnimatablePair
//struct Checkerboard: Shape {
//    var rows: Int
//    var columns: Int
//
//    //Código para fazer o Checkboard animado, nesse caso, eu preciso animar as rows e as columns
//    var animatableData: AnimatablePair<Double, Double> {
//        get {
//            AnimatablePair(Double(rows), Double(columns))
//        }
//
//        set {
//            rows = Int(newValue.first)
//            columns = Int(newValue.second)
//        }
//    }
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        let rowSize = rect.height / Double(rows)
//        let columnSize = rect.width / Double(columns)
//
//        for row in 0..<rows {
//            for column in 0..<columns {
//                if (row + column).isMultiple(of: 2) {
//                    let startX = columnSize * Double(column)
//                    let startY = rowSize * Double(row)
//
//                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
//                    path.addRect(rect)
//                }
//            }
//        }
//        return path
//    }
//}





//Creating a spirograph with SwiftUI
//struct Spiropraph: Shape {
//    let innerRadius: Int
//    let outerRadius: Int
//    let distance: Int
//    let amount: Double
//
//    func gcd(_ a: Int, _ b: Int) -> Int {
//        var a = a
//        var b = b
//
//        while b != 0 {
//            let temp = b
//            b = a % b
//            a = temp
//        }
//
//        return a
//    }
//
//    func path(in rect: CGRect) -> Path {
//        let divisor = gcd(innerRadius, outerRadius)
//
//        let outerRadius = Double(self.outerRadius)
//        let innerRadius = Double(self.innerRadius)
//        let distance = Double(self.distance)
//
//        let difference = innerRadius - outerRadius
//        let endPoint = ceil(2 * Double.pi * outerRadius / Double(distance)) * amount
//
//        var path = Path()
//
//        for theta in stride(from: 0, through: endPoint, by: 0.01) {
//            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
//            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
//
//            x += rect.width / 2
//            y += rect.height / 2
//
//            if theta == 0 {
//                path.move(to: CGPoint(x: x, y: y))
//            } else {
//                path.addLine(to: CGPoint(x: x, y: y))
//            }
//        }
//
//        return path
//    }
//}


//struct Arrow: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        //path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
//        //path.addLine(to: CGPoint(x: rect.midX, y: 0))
//        //path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
//        //path.addLine(to: CGPoint(x: rect.midX, y: 0))
//        //path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
//
//        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.midX, y: (rect.midY * -1) + 75))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY / 2))
//        path.addLine(to: CGPoint(x: rect.midX, y: (rect.maxY / 2) + 75))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
//
//
//        return path
//    }
//}


struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        color(for: value, brightness: 1),
                        lineWidth: 100
                    )
            }
        }
        .drawingGroup() //Isso faz com que o código rode MUITO mais rápido por que ele utiliza o GPU. Lembre-se: Tente sempre optimizar seu código antes de usar esse modificador.
    }
    
    func color( for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
    
        if targetHue > 1 {
            targetHue -= 1
        }
    
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    //@State private var petalOffset = -20.0
    //@State private var petalWidth = 100.0
    
    @State private var colorCycle = 0.0
    
    //@State private var amount = 0.0
    
    //@State private var insetAmount = 50.0
    
    //@State private var rows = 4
    //@State private var columns = 4
    
    //@State private var innerRadius = 125.0
    //@State private var outerRadius = 75.0
    //@State private var distance = 25.0
    //@State private var amount = 1.0
    //@State private var hue = 0.6
    
    
    //@State private var thicknessLines = 1.0
    
    var body: some View {
        //Creating custom paths with SwiftUI
        //Path { path in
            //path.move(to: CGPoint(x: 200, y: 100)) //Aqui eu desenho com as coordenadas que eu falo pra ele, ou seja, coordenadas fixas
            //path.addLine(to: CGPoint(x: 100, y: 300)) //CG significa Core Graphic
            //path.addLine(to: CGPoint(x: 300, y: 300))
            //path.addLine(to: CGPoint(x: 200, y: 100))
            //path.closeSubpath() //Aqui ele junta a ponta entre as linhas laterais, ele entende isso. Caso eu use o stroke com o StrokeStyle, o closesubpath não é necessário
        //}
        //.stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        //.stroke(.blue, lineWidth: 10)
        //.fill(.blue)
        
        
        
        
        //Paths vs shapes in SwiftUI
        //Triangle()
            //.stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            //.frame(width: 300, height: 300) //Aqui quer dizer que ele temm 300 de comprimento e 300 de altura para criar o triangulo
        //Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
            //.stroke(.blue, lineWidth: 10)
            //.frame(width: 300, height: 300)
        
        
        
        
        
        //Adding strokeBorder() support with InsettableShape
        //Circle() //A diferença entra o Arc e o Circle, é que ambos tem o protocolo shape, mas o circle tem também outro protocolo, o InsettableShape.
            //.strokeBorder(.blue, lineWidth: 40) //Esse stroke arruma pra gente pra não ficar fora da tela
            //.stroke(.blue, lineWidth: 40) //Observe que tá fora da tela
        
        
        
        
        
        
        //Transforming shapes using CGAffineTransform and even-odd fills
        //VStack {
            //Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                //.fill(.red, style: FillStyle(eoFill: true))
                //.stroke(.red, lineWidth: 1)
            
    //        Text("Offset")
    //        Slider(value: $petalOffset, in: -40...40)
    //            .padding([.horizontal, .bottom])
    //
    //        Text("Width")
    //        Slider(value: $petalWidth, in: 0...100)
    //            .padding(.horizontal)
    //    }
        
        
        
        
        
        //Creative borders and fills using ImagePaint
        //Text("Hello, world")
            //.frame(width: 300, height: 300)
            //.border(ImagePaint(image: Image("Example"), scale: 0.2), width: 50)
            //.border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.2), width: 50) //Esse sourceRect serve para quebrar a imagem do jeito que vc quiser
        //Capsule()
            //.strokeBorder(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.2), scale: 0.3), lineWidth: 20)
            //.frame(width: 300, height: 200)
        
        
        
        
        
        //Enabling high-performance Metal rendering with drawingGroup()
        //VStack {
        //    ColorCyclingCircle(amount: colorCycle)
        //        .frame(width: 300, height: 300)
        //
        //    Slider(value: $colorCycle)
        //}
        
        
        
        
        
        //Special effects in SwiftUI: blurs, blending, and more
        //ZStack {
        //    Image("Example")
        //
        //    Rectangle()
        //        .fill(.red)
        //        .blendMode(.multiply) //Ele pega os pixeis da imagem e altera para aquela cor, multiplica uma cor pela outra
        //}
        
        //Image("Example")
            //.colorMultiply(.red) //Faz a mesma coisa do de cima
        //VStack { //Observe esse overlap, ele multiplica as cores quando mistura elas
            //ZStack {
            //    Circle() //topo esquerdo
            //        .fill(.red) //Aqui, com o .red ele não me da a cor pura, se quiser, preciso usar o Color()
            //        .frame(width: 200 * amount)
            //        .offset(x: -50, y: -80)
            //        .blendMode(.screen)
            //
            //    Circle() //topo direito
            //        .fill(.green)
            //        .frame(width: 200 * amount)
            //        .offset(x: 50, y: -80)
            //        .blendMode(.screen)
            //
            //    Circle() //centro
            //        .fill(.blue)
            //        .frame(width: 200 * amount)
            //        .blendMode(.screen)
            //}
            //.frame(width: 300, height: 300)
            
            //Image("Example") //Coloca um blur na imagem
            //    .resizable()
            //    .scaledToFit()
            //    .frame(width: 200, height: 200)
            //    .saturation(amount)
            //    .blur(radius: (1 - amount) * 20)
            //
            //Slider(value: $amount)
            //    .padding()
        //}
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background(.black)
        //.ignoresSafeArea()
        
        
        
        
        
        
        //Animating simple shapes with animatableData
        //Trapezoid(insetAmount: insetAmount)
        //    .frame(width: 200, height: 100)
        //    .onTapGesture {
        //        withAnimation {
        //            insetAmount = Double.random(in: 10...90)
        //        }
        //    } //Quando clico no trapezoid ele troca o formato
        
        
        
        
        
        
        
        
        //Animating complex shapes with AnimatablePair
        //Checkerboard(rows: rows, columns: columns)
        //    .onTapGesture {
        //        withAnimation(.linear(duration: 3)) { //Aqui eu preciso ter 2 animações, pros rows e pras columns
        //            rows = 8 //O Swift não consegue interpolar inteiros!
        //            columns = 16
        //        }
        //    }
        
        
        
        
        
        
        
        //Creating a spirograph with SwiftUI
        //VStack(spacing: 0) {
        //    Spacer()
        //
        //    Spiropraph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
        //        .stroke(Color(hue:hue, saturation: 1, brightness: 1), lineWidth: 1)
        //        .frame(width: 300, height: 300)
        //
        //    Spacer()
        //
        //    Group {
        //        Text("Inner radius: \(Int(innerRadius))")
        //        Slider(value: $innerRadius, in: 10...150, step: 1)
        //            .padding([.horizontal, .bottom])
        //
        //        Text("Outer radius: \(Int(outerRadius))")
        //        Slider(value: $innerRadius, in: 10...150, step: 1)
        //            .padding([.horizontal, .bottom])
        //
        //        Text("Distance: \(Int(distance))")
        //        Slider(value: $innerRadius, in: 10...150, step: 1)
        //            .padding([.horizontal, .bottom])
        //
        //        Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
        //        Slider(value: $amount)
        //            .padding([.horizontal, .bottom])
        //
        //        Text("Color")
        //        Slider(value: $hue)
        //            .padding(.horizontal)
        //    }
        //}
        
        
        
        //VStack {
        //    Arrow()
        //        .stroke(.red, style: StrokeStyle(lineWidth: 10 * thicknessLines, lineCap: .round, lineJoin: .round))
        //        .frame(width: 300, height: 300)

        //    Text("Thickness")
        //    Slider(value: $thicknessLines, in: 1...10)
        //         .padding([.horizontal, .bottom])
        //}
        
        
        
        
        VStack {
            ColorCyclingRectangle(amount: colorCycle)
                .frame(width: 300, height: 300)
        
            Slider(value: $colorCycle)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
