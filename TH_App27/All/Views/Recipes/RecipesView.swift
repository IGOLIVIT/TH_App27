//
//  RecipesView.swift
//  TH_App27
//
//  Created by IGOR on 03/02/2025.
//

import SwiftUI

struct RecipesView: View {
    
    @StateObject var viewModel = RecipesViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Recipes")
                    .foregroundColor(.black)
                    .font(.system(size: 32, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 30)
                
                if viewModel.recipes.isEmpty {
                    
                    VStack(spacing: 14) {
                        
                        Text("Empty")
                            .foregroundColor(.black)
                            .font(.system(size: 22, weight: .bold))
                        
                        Text("You haven't added any recipes")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular))
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 14).fill(Color("prim1")))
                    
                    Spacer()
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.recipes, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.selectedRec = index
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDetail = true
                                    }
                                    
                                }, label: {
                                    
                                    VStack(alignment: .leading, spacing: 12) {
                                        
                                        HStack {
                                            
                                            Text(index.reName ?? "")
                                                .foregroundColor(.black)
                                                .font(.system(size: 18, weight: .semibold))
                                            
                                            Spacer()
                                            
                                            Text((index.reTime ?? Date()).convertDate(format: "HH:mm"))
                                                .foregroundColor(.black)
                                                .font(.system(size: 16, weight: .semibold))
                                                .padding(5)
                                                .padding(.horizontal, 6)
                                                .background(RoundedRectangle(cornerRadius: 7).fill(Color("prim2")))
                                        }
                                        
                                        HStack {
                                            
                                            VStack {
                                                
                                                Circle()
                                                    .fill(Color("prim3"))
                                                    .frame(width: 10)
                                                
                                                Circle()
                                                    .fill(Color("prim3"))
                                                    .frame(width: 10)

                                                Circle()
                                                    .fill(Color("prim3"))
                                                    .frame(width: 10)
                                            }
                                            
                                            VStack {
                                                
                                                Text(index.reIng ?? "")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 16, weight: .regular))
                                                
                                                Spacer()
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color("prim1")))
                                })
                            }
                        }
                    }
                }
            }
            .padding()
            
            VStack {
                
                Spacer()
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = true
                    }
                    
                }, label: {
                    
                    Text("New recipes +")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .regular))
                        .padding(8)
                        .padding(.horizontal, 9)
                        .background(RoundedRectangle(cornerRadius: 9).fill(Color("prim3")))
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
        }
        .onAppear {
            
            viewModel.fetchRecipes()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddRecipe(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            RecDetail(viewModel: viewModel)
        })
    }
}

#Preview {
    RecipesView()
}
