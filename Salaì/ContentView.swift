//
//  ContentView.swift
//  salai
//
//  Created by Francesca Mangino on 17/02/24.
//

import SwiftUI



struct ContentView: View {
   // @Binding var generating: Bool
    @State var selected = 0
    @State var isOverlayVisible = false
    @State var areImagesLoaded = false
    @State var SelectedImage: Image? = nil
    @State var prompt = ""
    @State var sketches: [UIImage] = []
    @State var Images: [Image] = []

    
    let filterOptions: [String] = ["Ai Results","Portfolio"]
    enum SwipeHorizontalDirection: String {
        case left, right, none
    }
    @State var swipeHorizontalDirection: SwipeHorizontalDirection = .none { didSet { print(swipeHorizontalDirection) } }
    
    
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.black
        
        let attributes:[NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor.white,
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
        UISegmentedControl.appearance().backgroundColor = UIColor.init(white: 1, alpha: 1)
        UISegmentedControl.appearance().layer.cornerRadius = 100
       // self._generating = generating
        
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image(selected==0 ? "AiResults": "Portfolio")
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                VStack{
                    Picker(selection: $selected,
                           label: Text("Picker"),
                           content: {
                        ForEach(filterOptions.indices){ index in Text(filterOptions[index])
                                .tag(filterOptions[index])
                            
                        }
                        
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .frame(width:800)
                    
                    
                    if selected == 0{
                        AiResultsView(isOverlayVisible: $isOverlayVisible, areImagesLoaded: $areImagesLoaded, Images: $Images, sketches: $sketches, selected: $selected).frame(height: 600)
                    }
                    else{
                        PortfolioView(selected: $selected, areImagesLoaded: $areImagesLoaded, Images: $Images, sketches: $sketches).frame(height: 600)
                    }
                    // }
                }}.ignoresSafeArea()
                .blur(radius: isOverlayVisible ? 5 : 0)
                
        }}}
    

#Preview {
    ContentView()
}
