//
//  AiResultsView.swift
//  salai
//
//  Created by Francesca Mangino on 17/02/24.
//

import SwiftUI
import PhotosUI

struct AiResultsView: View {

   // @Binding var generating: Bool
    @Binding var isOverlayVisible: Bool
    @State var showResults: Bool = false
    @State  var results: [Image] = []
    @Binding var areImagesLoaded: Bool
    @Binding var Images: [Image]
    @Binding var sketches: [UIImage]
    @Binding var selected: Int
    @State var prompt: String = ""
    enum SwipeHorizontalDirection: String {
        case left, none
    }
    @State var swipeHorizontalDirection: SwipeHorizontalDirection = .none { didSet { print(swipeHorizontalDirection) } }
    
    var viewModel = AiResultsViewModel()
    
    var body: some View {
        ZStack{
            Rectangle().opacity(0.01).frame(width: 1000, height: 1200)
                .foregroundStyle(.gray)
            VStack{
                Text("Unleash")
                    .font(.system(size: 96))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, -15)
                Text("your")
                    .font(.system(size: 96))
                    .fontWeight(.bold)
                    .padding(-15)
                Text("creativity")
                    .font(.system(size: 96))
                    .fontWeight(.bold)
                .padding(.top, -15)
                
                
         
                    NavigationLink(destination: WaitingView(prompt: $prompt, finalimage: UIImage(), sketches: $sketches, Images: $Images), label:{
                        HStack{
                            Image(systemName: "wand.and.stars")
                                .resizable()
                                .foregroundStyle(.white)
                                .frame(width: 30, height: 30)
                                .padding(.leading)
                            Text("Generate a new sketch")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundStyle(.white)
                                .padding()
                        }
                        .frame(width: 300)
                        .padding(15)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 48, style: .continuous))
                    })}
                
         
            }

            .gesture(DragGesture()
                .onChanged {
                    print("dragging from aiResults")
                    if $0.startLocation.x > $0.location.x {
                        self.swipeHorizontalDirection = .left
                        selected=1
                        
                    }})
            .overlay(
                Group {
                    if showResults {
                        ZStack{
                            Rectangle()
                                .opacity(0.2)
                                .frame(width: 1200, height: 1200)
                                .foregroundStyle(.black)
                                .ignoresSafeArea().onTapGesture {
                                    showResults = false
                                    }
                        
                            RoundedRectangle(cornerRadius: 12.0).foregroundColor(.white)
                                .frame(width: 500, height: 600, alignment: .center)
        
                            VStack {
                        
                                    Text("Results")
                                        .fontWeight(.heavy)
                                        .bold()
                                        .frame(width: 500)
                                
                                if results.count>0{
                                    ScrollView {
                                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 5) {
                                            ForEach(results.indices, id: \.self) { index in
                                                results[index]
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 100, height: 100)
                                                    .cornerRadius(8)
                                                    
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
                                        Text("")
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
