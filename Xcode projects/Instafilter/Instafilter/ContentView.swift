//
//  ContentView.swift
//  Instafilter
//
//  Created by Marko Kramar on 17/10/2020.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    
    @State private var showingImagePicker = false
    
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    
    @State private var processedImage: UIImage?
    
    @State private var alertShown = false
    @State private var alertMessage = ""
    
    @State private var selectedFilter = ""
    
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        let radius = Binding<Double>(
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }.padding(.vertical)
                
                HStack {
                    Text("Radius")
                    Slider(value: radius)
                }.padding(.vertical)
                
                HStack {
                    Button(selectedFilter == "" ? "Change Filter" : selectedFilter) {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = processedImage else {
                            alertShown = true
                            alertMessage = "Please choose photo before saving it"
                            return
                        }
                        
                        let imageSaver = ImageSaver()
                        imageSaver.successHandler = {
                            alertShown = true
                            alertMessage = "Image was saved successfully."
                        }
                        
                        imageSaver.errorHandler = {
                            alertShown = true
                            alertMessage = "Error while saving image!"
                            print("Error: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writePhotosToAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    actionSheetButton(withFilterText: "Crystallize", withActualFilter: CIFilter.crystallize()),
                    actionSheetButton(withFilterText: "Edges", withActualFilter: CIFilter.edges()),
                    actionSheetButton(withFilterText: "Gaussian Blur", withActualFilter: CIFilter.gaussianBlur()),
                    actionSheetButton(withFilterText: "Pixellate", withActualFilter: CIFilter.pixellate()),
                    actionSheetButton(withFilterText: "Sepia Tone", withActualFilter: CIFilter.sepiaTone()),
                    actionSheetButton(withFilterText: "Unsharp Mask", withActualFilter: CIFilter.unsharpMask()),
                    actionSheetButton(withFilterText: "Vignette", withActualFilter: CIFilter.vignette()),
                    .cancel()
                ])
            }
            .alert(isPresented: $alertShown) {
                Alert(title: Text("Saving image"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func actionSheetButton(withFilterText text: String, withActualFilter filter: CIFilter) -> ActionSheet.Button {
        .default(Text(text)) {
            self.setFilter(filter)
            self.selectedFilter = text
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}
