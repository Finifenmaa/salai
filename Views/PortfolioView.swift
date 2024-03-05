//
//  PortfolioView.swift
//  salai
//
//  Created by Francesca Mangino on 17/02/24.
//

import SwiftUI
import PhotosUI
//import UIKit

extension Image {
    func asUIImage() -> UIImage? {
        // Render the SwiftUI Image into a UIImage
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let renderer = UIGraphicsImageRenderer(size: view!.bounds.size)
        let image = renderer.image { context in
            view!.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
        
        return image
    }
}

struct PortfolioView: View {
    @Binding var selected: Int
    @Binding var areImagesLoaded: Bool
    enum SwipeHorizontalDirection: String {
        case right, none
    }
    @State var swipeHorizontalDirection: SwipeHorizontalDirection = .none { didSet { print(swipeHorizontalDirection) } }
    
    @State private var avatarPhotoItems: [PhotosPickerItem] = []
    @Binding var Images: [Image]
    @State var showImages = false
    @State var SelectedImage: Image? = nil
    @State var selectedIndex: Int = 0
    @State var recoveredSketch: UIImage = UIImage()
    @State var imageRecovered = false
    @Binding var sketches: [UIImage] 
    var viewModel = PortfolioViewModel()
    
    
    
    var body: some View {ZStack{
        ZStack{
            Rectangle().opacity(0.01).frame(width: 1000, height: 600)
                .foregroundStyle(.gray)
            VStack{
                Text("Your")
                    .font(.system(size: 192))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, -40)
                Text("portfolio")
                    .font(.system(size: 192))
                    .fontWeight(.bold)
                    .padding(.top, -40)

 
                    
                Button(action: {showImages=true}){
                    HStack{
                        Image(systemName: "photo.artframe")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 30, height: 30)
                            .padding(.leading)
                        Text("Sketches")
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundStyle(.white)
                            .padding()
                    }
                    .frame(width: 250)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
            }
        }
        .gesture(DragGesture()
            .onChanged {
                print("dragging from Portfolio")
                if $0.startLocation.x < $0.location.x {
                    self.swipeHorizontalDirection = .right
                    selected=0
                    
                }})
        VStack{
            Spacer().frame(height: 400)
            }
        }.overlay(
            Group {
                if showImages {
                    ZStack{
                        Rectangle()
                            .opacity(0.2)
                            .frame(width: 1200, height: 1200)
                            .foregroundStyle(.black)
                            .ignoresSafeArea().onTapGesture {
                                showImages = false
                                print(showImages)}

                        
                        RoundedRectangle(cornerRadius: 12.0).foregroundColor(.white)
                            .frame(width: 500, height: 600, alignment: .center)
                        
                        VStack {
                            HStack{
                                Button("Cancel"){
                                    SelectedImage=nil
                                    showImages=false
                                }.foregroundStyle(.black)
                                    .bold()
                                Spacer()
                                
                                Text("Select your reference")
                                    .fontWeight(.heavy)
                                    .bold()
                                Spacer()
                                Button("Done"){
                                    recoveredSketch = (SelectedImage?.asUIImage())!
                                    print(recoveredSketch)
                                    imageRecovered = true
                                        
                                }
                                .foregroundStyle(.black)
                                .bold()
                                .navigationDestination(isPresented: $imageRecovered){CanvaView(sketch: sketches.count>0 ? sketches[selectedIndex] : UIImage(), sketches: $sketches, Images: $Images, prompt: .constant(""))}
                                
                            }.frame(width: 500)
                            
                            if Images.count>0{
                                ScrollView {
                                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 5) {
                                        ForEach(Images.indices, id: \.self) { index in
                                            Images[index]
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(8)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color.black, lineWidth: SelectedImage == Images[index] ? 3 : 0)
                                                )
                                                .onTapGesture {
                                                    // Set the selected image
                                                    SelectedImage = Images[index]
                                                    selectedIndex = index
                                                    print(index)
                                                    print("Selected image: \(SelectedImage)")
                                                }
                                        }
                                    }
                                    
                                }.frame(width: 500, height: 500, alignment: .center)
                                
                                    .padding()
                                
                            }else{
                                Spacer()
                                Text("No images uploaded in Your Portfolio")
                                    .font(.headline)
                                    .foregroundStyle(.gray)
                                
                                
                                Spacer()
                                HStack{
                                    Text("Cancel")
                                    Spacer()
                                        .foregroundStyle(.blue)
                                    Text("Select your reference")
                                        .fontWeight(.heavy)
                                        .bold()
                                    Spacer()
                                    Text("Done")
                                        .foregroundStyle(.blue)
                                        .bold()
                                    
                                }.frame(width: 500)
                                    .opacity(0)
                            }
                            
                            
                            
                            
                        }
                    }
                }}
            
            
        ).frame(height: 650)
        }
            
            

            
}


#Preview {
    PortfolioView(selected: .constant(1), areImagesLoaded: .constant(false), Images: .constant([]), sketches: .constant([]))
}
