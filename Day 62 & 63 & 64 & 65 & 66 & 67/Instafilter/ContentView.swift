//
//  ContentView.swift
//  Instafilter
//
//  Created by Deraldo on 19/10/22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    //@State private var blurAmount = 0.0 {
        //didSet { //Quando a struct @State que contém o blurAmount mudar, print o novo blurAmount, e NÃO: Quando o BlurAmount mudar, print o novo valor. Como consequência, se vc mudar pelo slider, ele vai tá mudando o valor do BlurAmount, e não da struct @State, logo, não vai printar
            //print("New value is \(blurAmount)")
        //}
    
    //@State private var blurAmount = 0.0
    
    
    //@State private var showingConfirmation = false
    //@State private var backgroundColor = Color.white
    
    
    @State private var image: Image?
    //@State private var inputImage: UIImage?
    //@State private var showingImagePicker = false
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.0
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone() //Pode ser qualquer filtro colocando o CIFilter
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    var body: some View {
        //VStack {
        //    Text("Hello, world!")
        //        .blur(radius: blurAmount)
        //
        //    Slider(value: $blurAmount, in: 0...20)
                //Com esse onChange, eu consigo imprimir os valores reais do blurAmount, e eu posso colocar esse onChange aonde eu quiser
          //      .onChange(of: blurAmount) { newValue in
          //          print("New value is \(newValue)")
          //      }
          //
          //  Button("Random Blur") {
          //      blurAmount = Double.random(in: 0...20)
          //  }
        //}
        
        
        
        
        
        //Showing multiple options with confirmationDialog()
        //Text("Hello, world!")
        //    .frame(width: 300, height: 300)
        //    .background(backgroundColor)
        //    .onTapGesture {
        //        showingConfirmation = true
        //    }
        //    .confirmationDialog("Change background", isPresented: $showingConfirmation) {
        //        Button("Red") { backgroundColor = .red }
        //        Button("Green") { backgroundColor = .green }
        //        Button("Blue") { backgroundColor = .blue }
        //        Button("Cancel", role: .cancel) { }
        //    } message: {
        //        Text("Select a new color")
        //    }
        
        
        
        
        
        
        
        //Integrating Core Image with SwiftUI
        //VStack {
            //image?
                //.resizable()
                //.scaledToFit()
        //}
        //.onAppear(perform: loadImage)
        
        
        
        
        
        
        //Wrapping a UIViewController in a SwiftUI
        //VStack {
        //    image?
        //        .resizable()
        //        .scaledToFit()
        //
        //    Button("Select Image") {
        //        showingImagePicker = true
        //    }
        //
        //    Button("Save image") {
        //        guard let InputImage = inputImage else { return }
        //
        //        let imageSaver = ImageSaver()
        //        imageSaver.writeToPhotoAlbum(image: InputImage)
        //    }
        //}
        //.sheet(isPresented: $showingImagePicker) {
        //    ImagePicker(image: $inputImage)
        //}
        //.onChange(of: inputImage) { _ in loadImage() }
    
    //func loadImage() {
        //image = Image("Example") //Image é uma View muito poderosa que trabalha com 3 tipos de image para retornar a imagem, ui image, ci image e cg image trabalham juntas.
        //guard let inputImage = UIImage(named: "Example") else { return } //core image não consegue ler isso, ele precisa do CIImage
        //let beginImage = CIImage(image: inputImage)
        
        // MORE CODE TO COME
        //let context = CIContext()
        //let currentFilter = CIFilter.sepiaTone() //Coloco o tom sepia
        //let currentFilter = CIFilter.pixellate() //coloca a img pixelada
        //let currentFilter = CIFilter.crystallize() //coloca a imagem cristalizada
        //let currentFilter = CIFilter.twirlDistortion()
        //currentFilter.inputImage = beginImage
        
        //let amount = 1.0
        //let inputKeys = currentFilter.inputKeys
        
        //if inputKeys.contains(kCIInputIntensityKey) { //Consigo fazer a injeção dinamica do filtro
            //currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        //}
        
        //if inputKeys.contains(kCIInputRadiusKey) {
            //currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
        //}
        
        //if inputKeys.contains(kCIInputScaleKey) {
            //currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
        //}
        //currentFilter.intensity = 1
        //currentFilter.scale  100
        //currentFilter.radius = 1000
        //currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
        
        //guard let outputImage = currentFilter.outputImage else { return }
        
        //if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            //let uiImage = UIImage(cgImage: cgimg)
            //image = Image(uiImage: uiImage)
        //}
        
        
        
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                VStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in applyProcessing() } //Aqui eu precisei do onchange pq o binding não funciona por conta da imagem
                    Text("Radius")
                    Slider(value: $filterRadius)
                        .onChange(of: filterRadius) { _ in applyProcessing() } //Aqui eu precisei do onchange pq o binding não funciona por conta da imagem
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                        .disabled(image == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Group {
                    Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                    Button("Edges") { setFilter(CIFilter.edges()) }
                    Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                    Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                    Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                }
                Group {
                    Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                    Button("Vignette") { setFilter(CIFilter.vignette()) }
                    Button("Thermal") { setFilter(CIFilter.thermal()) }
                    Button("Bloom") { setFilter(CIFilter.bloom()) }
                    Button("Gloom") { setFilter(CIFilter.gloom()) }
                    Button("Cancel", role: .cancel) { }
                }
                
            }
        }
    }
    
    //func loadImage() {
    //    guard let inputImage = inputImage else { return }
    //    image = Image(uiImage: inputImage)
    //
    //}
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        //image = Image(uiImage: inputImage)
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey) //Coloca o filtro
        applyProcessing()

    }
    
    func save () {
        //Salvar a imagem com filtro
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { //Meu filtro possui intensidade?
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) { //Possui radius?
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) { //Possui escala?
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 100, forKey: kCIInputRadiusKey)
        }
        //currentFilter.intensity = Float(filterIntensity) //Sem o CIFilter
        
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            //Salvar a imagem com filtro
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
