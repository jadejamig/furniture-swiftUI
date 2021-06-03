//
//  DetailedView.swift
//  FurnitureApp
//
//  Created by Anselm Jade Jamig on 6/2/21.
//

import SwiftUI

struct DetailedView: View {
    var namespace: Namespace.ID
    var furniture: Furniture
    
    @State var selectedColor: Color?
    @State var numberOfItems: Int = 1
    @State var isFavorite: Bool = true
    
    @Binding var showDetailed: Bool
    @Binding var isDisabled: Bool
    
    private let generator = UISelectionFeedbackGenerator()
    
    var body: some View {
            self.content
                .edgesIgnoringSafeArea(.all)
    }
    
    @ViewBuilder
    var content: some View {
        VStack {
            ScrollView {
                PopularCard(furniture: self.furniture, showDetailed: $showDetailed, isDisabled: $isDisabled)
                    .frame(height: 300)
                    .matchedGeometryEffect(id: furniture.id, in: self.namespace)
            
                VStack(spacing: 16) {
                    HStack {
                        Text(self.furniture.name)
                            .font(.title.bold())
                        Spacer()

                        Image(systemName: self.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.red.opacity(0.7))
                            .font(.title3)
                            .onTapGesture {
                                self.isFavorite.toggle()
                                self.generator.selectionChanged()
                            }
                    }

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Manufactured by")
                                .foregroundColor(.black.opacity(0.3))
                                .font(.subheadline)
                            Text("\(self.furniture.seller)")
                                .font(.title3)
                                .bold()
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(self.furniture.stars).0")
                                .bold()
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                                .stroke(Color.black.opacity(0.3))
                        )
                    }

                    VStack {
                        //Text(Lorem.sentences(3))
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                    }
                    .frame(height: 170)


                     Spacer()

                    HStack {
                        Text("Color")
                            .font(.title3)
                            .bold()
                            .padding(.trailing)

                        HStack(spacing: 16) {
                            ForEach(0..<self.furniture.colors.count) { index in
                                VStack {
                                    Circle()
                                        .frame(width: 15, height: 15)
                                        .foregroundColor(self.furniture.colors[index])
                                }
                                .padding(3)
                                .overlay(
                                    Circle()
                                        .stroke(Color.black)
                                )
                            }
                        }
                        Spacer()

                        HStack {
                            Image(systemName: "minus")
                                .font(.title)
                                .onTapGesture {
                                    self.generator.selectionChanged()
                                    if self.numberOfItems > 1 {
                                        self.numberOfItems = self.numberOfItems - 1
                                        print(self.numberOfItems)
                                    }
                                }
                            Spacer()
                            Text("\(self.numberOfItems)")
                                .bold()
                            Spacer()
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .onTapGesture {
                                    self.generator.selectionChanged()
                                    if self.numberOfItems < 10 {
                                        self.numberOfItems += 1
                                        print(self.numberOfItems)
                                    }
                                }
                        }
                        .frame(width: 120)
                        .padding(.leading)
                        .background(Color.black.opacity(0.05))
                        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    }


                    HStack {
                        Text("$\(self.furniture.price * Float(self.numberOfItems), specifier: "%.2f")")
                            .font(.largeTitle).bold()
                        Spacer()
                        Button(action: {self.generator.selectionChanged()}, label: {
                            Text("Buy Now")
                                .foregroundColor(.white)

                        })
                        .padding()
                        .padding(.horizontal)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))

                    }
                    .padding(.top)


                }
                .padding()
                .padding(.top)
                
                
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .matchedGeometryEffect(id: "container\(furniture.id)", in: self.namespace)
    }
}

struct DetailedView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        DetailedView(namespace: namespace, furniture: furnitures[0], showDetailed: .constant(true), isDisabled: .constant(true))
    }
}
