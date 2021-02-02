//
//  ContentView.swift
//  ConferenceMeetup
//
//  Created by Marko Kramar on 31/10/2020.
//

import SwiftUI
import MapKit

struct PhotoJson: Codable {
    var id: UUID
    var name: String
}

struct Photo: Identifiable, Comparable {
    var id: UUID
    var name: String
    var image: UIImage
    
    static func < (lhs: Photo, rhs: Photo) -> Bool {
        lhs.name < rhs.name
    }
}

class PhotoStore: ObservableObject {
    @Published var photos = [Photo]()
    
    init() {
        let filename = PhotoStore.getDocumentsDirectory().appendingPathComponent("SavedImages")
        
        do {
            let data = try Data(contentsOf: filename)
            let photosCodable = try JSONDecoder().decode([PhotoJson].self, from: data)
            
            for photoJson in photosCodable {
                let imageUrlToReadFrom = PhotoStore.getDocumentsDirectory().appendingPathComponent("\(photoJson.id).png")
                let image = UIImage(contentsOfFile: imageUrlToReadFrom.path)
                if image != nil {
                    photos.append(Photo(id: photoJson.id, name: photoJson.name, image: image!))
                }
            }
        } catch {
            print("Unable to load saved images")
            print("Exact error: \(error.localizedDescription)")
        }
    }
    
    func persist() {
        let filename = PhotoStore.getDocumentsDirectory().appendingPathComponent("SavedImages")
        
        var photosJson = [PhotoJson]()
        for photo in photos {
            let imageUrlToWriteTo = PhotoStore.getDocumentsDirectory().appendingPathComponent("\(photo.id).png")
            if let pngData = photo.image.pngData() {
                try? pngData.write(to: imageUrlToWriteTo)
            }
            
            photosJson.append(PhotoJson(id: photo.id, name: photo.name))
        }
        
        do {
            let data = try JSONEncoder().encode(photosJson)
            try data.write(to: filename, options: [.atomicWrite])
        } catch {
            print("Unable to save data")
            print("Exact error: \(error.localizedDescription)")
        }
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct InsertView: View {
    @State var photoStore: PhotoStore
    
    @State private var showingImagePicker = false
    @State private var photoName = ""
    @State private var photoInputImage: UIImage?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Photo name", text: $photoName)
                    if photoInputImage != nil {
                        Image(uiImage: photoInputImage!)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .onAppear {
                    showingImagePicker = true
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $photoInputImage)
                }
                
                Button("Save") {
                    savePhoto()
                }
                .disabled(isPhotoNameEmptyOrImageNotSelected())
            }
            .navigationBarTitle(Text("Add photo"))
        }
    }
    
    func isPhotoNameEmptyOrImageNotSelected() -> Bool {
        photoName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || photoInputImage == nil
    }
    
    func savePhoto() {
        self.photoStore.photos.append(Photo(id: UUID(), name: photoName, image: photoInputImage!))
        self.photoStore.persist()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView: View {
    @State var photo: Photo
    var locationFetcher: LocationFetcher
    
    var body: some View {
        VStack {
            Form {
                TextField("Photo name", text: $photo.name)
                    .disabled(true)
                
                Image(uiImage: photo.image)
                    .resizable()
                    .scaledToFit()
            }
            .navigationBarTitle(Text(photo.name), displayMode: .inline)
            
            MapView(centerCoordinate: locationFetcher.lastKnownLocation!, annotations: [createMkPointAnnotation(location: locationFetcher.lastKnownLocation!)])
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    func createMkPointAnnotation(location: CLLocationCoordinate2D) -> MKPointAnnotation {
        let locationAnnotation = MKPointAnnotation()
        locationAnnotation.coordinate = location
        locationAnnotation.title = "Place where photo is taken"
        return locationAnnotation
    }
}

struct ContentView: View {
    @ObservedObject private var photoStore = PhotoStore()
    @State private var showingInsertView = false
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationView {
            List(photoStore.photos.sorted()) { photo in
                NavigationLink(destination: DetailView(photo: photo, locationFetcher: locationFetcher)) {
                    Text("\(photo.name)")
                }
            }
            .navigationBarTitle(Text("Conference photos"))
            .navigationBarItems(trailing: Button(action: {
                self.showingInsertView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingInsertView) {
                InsertView(photoStore: photoStore)
            }
        }.onAppear {
            self.locationFetcher.start()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
