//
//  ContentView.swift
//  FurnitureApp
//
//  Created by Anselm Jade Jamig on 6/2/21.
//

import SwiftUI
import SwiftUIX

struct ContentView: View {
    @State var searchText: String = ""
    @Namespace var namespace
    @State var selectedFurniture: Furniture? = nil
    @State var showDetailed: Bool = false
    @State var isDisabled = false
    
    private let generator = UISelectionFeedbackGenerator()
    
    var body: some View {
        
        ZStack {
            self.tabBar
                .statusBar(hidden: true)
            self.fullContent
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
                .statusBar(hidden: self.showDetailed)
                
            
        }
        
            
    }
    
    //MARK: - CONTENT section
    var content: some View {
        
        ScrollView(.vertical) {
            HStack {
                HStack(spacing: 16) {
                    HStack {
                        Image("jade2")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    
                    Text("Jade Jamig")
                        .bold()
                }
                
                VStack {
                    Text("Verified")
                        .font(.footnote)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .foregroundColor(.green)
                    
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .stroke(Color.green, lineWidth: 1.0)
                )
                
                Spacer()
                
                HStack(spacing: 16) {
                    Image(systemName: "cart")
                        .font(.title3)
                        .onTapGesture {
                            self.generator.selectionChanged()
                        }
                    Image(systemName: "ellipsis.bubble")
                        .font(.title3)
                        .onTapGesture {
                            self.generator.selectionChanged()
                        }
                }
                
                
            }
            .padding()
            // End of HStack
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading)
                TextField("Search", text: self.$searchText) { isEditing in
                    self.generator.selectionChanged()
                }
                    .padding(.vertical, 8)
                    .padding(.trailing)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .stroke(Color.black.opacity(0.3),lineWidth: 1)
            )
            .padding([.horizontal])
            
            HStack {
                Text("Categories")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding([.horizontal, .top])
            .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 25) {
                    CategoryCard(category: "Chair", img: "chair")
                    CategoryCard(category: "Bed", img: "bed")
                    CategoryCard(category: "Rack", img: "rack")
                }
                .padding()
                .padding(.bottom)
            }
            
            HStack {
                Text("Popular")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding(.horizontal)
            
            ForEach(furnitures) { furniture in
                VStack {
                    PopularCard(furniture: furniture, showDetailed: $showDetailed, isDisabled: $isDisabled)
                        .padding()
                        .matchedGeometryEffect(id: furniture.id, in: self.namespace, isSource: !self.showDetailed)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                self.selectedFurniture = furniture
                                self.showDetailed = true
                                self.isDisabled = true
                            }
                        }
                        .disabled(self.isDisabled)
                }
                .matchedGeometryEffect(id: "container\(furniture.id)", in: self.namespace, isSource: !self.showDetailed)
            }
        }
        .navigationTitle("Furniture")
        .navigationBarItems(trailing: Button(action: {}) {
            Image(systemName: "line.horizontal.3")
                .font(.title)
                .foregroundColor(.black)
            }
        )
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    
    //MARK: - TabBar Section
    
    var tabBar: some View {
        TabView {
            NavigationView {
                content
            }
            .tabItem {
                Image(systemName: "house")
                Text("Discover")
            }
            NavigationView {
                EmptyView()
            }
            .tabItem {
                Image(systemName: "heart")
                Text("Wishlist")
            }
            NavigationView {
                EmptyView()
            }
            .tabItem {
                Image(systemName: "creditcard")
                Text("Wallet")
            }
            NavigationView {
                EmptyView()
            }
            .tabItem {
                Image(systemName: "bell")
                Text("Notifications")
            }
            NavigationView {
                EmptyView()
            }
            .tabItem {
                Image(systemName: "person")
                Text("Account")
            }
            
            
        }
    }
    
    //MARK: - Fullscreen section
    
    @ViewBuilder
    var fullContent: some View {
        if self.selectedFurniture != nil && self.showDetailed {
            ZStack(alignment: .topTrailing) {
                DetailedView(namespace: self.namespace, furniture: self.selectedFurniture!, showDetailed: $showDetailed, isDisabled: $isDisabled)
                
                
            }
            .zIndex(2)
            .frame(maxWidth: 712)
            // End of ZStack fullscreen
        }
    }
    
    //MARK: - Hide Keyboard function
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: - CATEGORY CARD section

struct CategoryCard: View {
    var category: String
    var img: String
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                Image(self.img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(width: 200, height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 10)
            
            Text(self.category)
                .font(.title3)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding()
        }
    }
}

//MARK: - POPULAR CARD section
struct PopularCard: View {
    var furniture: Furniture
    @Binding var showDetailed: Bool
    @Binding var isDisabled: Bool
    
    var body: some View {
        VStack {
            ZStack {
                Image(self.furniture.image)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                
                // Start Close Button
                VStack {
                    HStack {
                        Spacer()
                        CloseButton()
                            .padding(25)
                            .padding(.top)
                            .opacity(self.showDetailed ? 1 : 0)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    self.showDetailed.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        self.isDisabled = false
                                    }
                                }
                        }
                    }
                    Spacer()
                }
                // End Close button
                
                VStack {
                    Spacer()
                    HStack {
                        ForEach(0 ..< self.furniture.stars) { item in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.caption2)
                        }
                        ForEach(0 ..< 5 - self.furniture.stars) { item in
                            Image(systemName: "star")
                                .foregroundColor(.yellow)
                                .font(.caption2)
                        }
                        Spacer()
                    }
                }
                .padding(25)
            }
        }
        .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 10)
    }
}
