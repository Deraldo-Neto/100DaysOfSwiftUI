//
//  ContentView.swift
//  WhoIsWho
//
//  Created by Deraldo on 10/01/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var whos: FetchedResults<Who>
    
    @State private var showingAddScreen = false
    
    @State private var locations = [Location]()
    @State private var mapRegion = MKCoordinateRegion()
    
    let savePath = FileManager.documentsDirectory
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(whos) { who in
                    NavigationLink {
                        DetailView(who: who, locations: [Location(id: who.locationArray.first!.id, latitude: who.locationArray.first!.latitude, longitude: who.locationArray.first!.longitude)])
                    } label: {
                        imageWho(who: who)!
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .frame(width: 100, height: 100)
                            
                        Spacer()
                        VStack {
                            Text(who.name ?? "Unknown Title")
                                .font(.headline)
                        }
                        .padding()
                    }
                }
                .onDelete(perform: deleteWhos)
            }
            .navigationTitle("Who is who?")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        locations.removeAll()
                        let newLocation = Location(id: UUID(), latitude: self.locationFetcher.lastKnownLocation!.latitude, longitude: locationFetcher.lastKnownLocation!.longitude)
                        locations.append(newLocation)
                        
                        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.locationFetcher.lastKnownLocation!.latitude, longitude: locationFetcher.lastKnownLocation!.longitude), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Who", systemImage: "plus.circle")
                            .font(.system(size: 25))
                    }
                }
            }
            .fullScreenCover(isPresented: $showingAddScreen) {
                AddWhoView(locations: $locations, mapRegion: $mapRegion)
            }
        }
    }
    
    init() {
        self.locationFetcher.start()
    }
    
    func imageWho(who: Who) -> Image? {
        if let data = try? Data(contentsOf: savePath.appendingPathComponent("\(who.id!.uuidString).jpeg")),
           let image = UIImage(data: data) {
            return Image(uiImage: image)
            
        } else {
            return nil
        }
    }
    
    func deleteWhos(at offsets: IndexSet) {
        for offset in offsets {
            let who = whos[offset]
            moc.delete(who)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
