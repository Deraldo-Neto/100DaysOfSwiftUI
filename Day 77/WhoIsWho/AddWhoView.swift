//
//  AddWhoView.swift
//  WhoIsWho
//
//  Created by Deraldo on 10/01/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI
import LocalAuthentication
import MapKit

struct AddWhoView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var image: Image?
    @State private var name = ""
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    let locationFetcher = LocationFetcher()
    
    @Binding var locations: [Location]
    
    @Binding var mapRegion: MKCoordinateRegion
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.primary)
                        .clipShape(Circle())
                        .scaledToFit()
                        .padding()
                        .frame(width: 250, height: 250)
                        .opacity(image != nil ? 0 : 1)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .clipShape(Circle())
                        .padding()
                        .frame(width: 250, height: 250)
                        .opacity(image != nil ? 1 : 0)
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                VStack {
                    TextField("Place name", text: $name)
                        .padding()
                        .padding(.horizontal, 35)
                        .background {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.gray, lineWidth: 1)
                                    .frame(width: 300, height: 50)
                            }
                        }
                        .padding([.horizontal, .bottom])
                }
                
                ZStack {
                    Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                        MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding()
                    
                }
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.system(size: 25))
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(.red)
                    .padding(.horizontal)
                    Button {
                        save()
                    } label: {
                        Text("Save")
                            .font(.system(size: 25))
                            .disabled(validWho())
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(validWho() ? .blue : .gray)
                    .padding(.horizontal)
                }

                Spacer()
            }
            .navigationTitle("Add who?")
            .onChange(of: inputImage) { _ in loadImage() }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        processedImage = inputImage
    }
    
    func validWho() -> Bool {
        if image == nil || name.isEmpty {
            return false
        }
        return true
    }
    
    func save () {
        let newUuid = UUID()
        
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage, id: newUuid)
        
        let newLocation = CachedLocation(context: moc)
        newLocation.id = locations.first!.id
        newLocation.latitude = locations.first!.latitude
        newLocation.longitude = locations.first!.longitude
        newLocation.who = Who(context: moc)
        newLocation.who.id = newUuid
        newLocation.who.name = name
        
        try? moc.save()
        dismiss()
    }
    
    
}
