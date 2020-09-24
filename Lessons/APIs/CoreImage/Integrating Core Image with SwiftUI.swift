//
//  ContentView.swift
//  InstaFilter
//
//  Created by Benjamin Keys on 9/24/20.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    func loadImage() {
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
//        let currentFilter = CIFilter.sepiaTone()  // filter 1
//        let currentFilter = CIFilter.pixellate()  // filter 2
//        let currentFilter = CIFilter.crystallize()  // filter 3
        // filter 4 - uses old API because not all filters have been update to intigrate
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
        
//        currentFilter.inputImage = beginImage // not used in old api
        
//        currentFilter.intensity = 1  // filter 1
//        currentFilter.scale = 100  // filter 2
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)  // filter 3
            /** `kCIInputImageKey` **/// is a special constant that specifies the input image for a filter

        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
