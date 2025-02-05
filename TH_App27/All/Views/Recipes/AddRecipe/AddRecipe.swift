//
//  AddRecipe.swift
//  TH_App27
//
//  Created by IGOR on 03/02/2025.
//

import SwiftUI

struct AddRecipe: View {
    
    @StateObject var viewModel: RecipesViewModel
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New recipes")
                        .foregroundColor(.black)
                        .font(.system(size: 22, weight: .regular))
                 
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = false
                        }
                        
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .medium))
                    })
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 14) {
                        
                        Text("Recipes name")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        ZStack(content: {
                            
                            Text("Enter")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.reName.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.reName)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                            .padding(.vertical, 5)
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 14) {
                                
                                Text("Temperature")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
                                
                                HStack {
                                    
                                    ZStack(content: {
                                        
                                        Text("0")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 15, weight: .regular))
                                            .opacity(viewModel.reTemp.isEmpty ? 1 : 0)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        TextField("", text: $viewModel.reTemp)
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 16, weight: .regular))
                                        
                                    })
                                    
                                    Text("℃")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 16, weight: .regular))
                                        .padding(.trailing, 60)

                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 14) {
                                
                                Text("Cooking time")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
                                
                                HStack {
                                    
                                    DatePicker("", selection: $viewModel.reTime, displayedComponents: .hourAndMinute)
                                        .labelsHidden()
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        
                        VStack(alignment: .leading, spacing: 14) {
                            
                            Text("Main Ingredients")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                            
                            ZStack(content: {
                                
                                Text("Enter Ingredient")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.reIng.isEmpty ? 1 : 0)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                TextField("", text: $viewModel.reIng)
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 16, weight: .regular))
                                
                            })
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(maxWidth: .infinity)
                                .frame(height: 1)
                                .padding(.vertical, 5)
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 14).fill(.gray.opacity(0.1)))
                        
                        Text("Recipe description")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        ZStack(content: {
                            
                            Text("Enter")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.reDescr.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.reDescr)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                            .padding(.vertical, 5)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                        viewModel.addRecipe()
                        
                        viewModel.reName = ""
                        viewModel.reTemp = ""
                        viewModel.reIng = ""
                        viewModel.reDescr = ""
                        
                        viewModel.fetchRecipes()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = false
                        }
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim3")))
                    })
                    .opacity(viewModel.reName.isEmpty || viewModel.reTemp.isEmpty || viewModel.reIng.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.reName.isEmpty || viewModel.reTemp.isEmpty || viewModel.reIng.isEmpty ? true : false)
                }
            }
            .padding()
        }
    }
}

#Preview {
    AddRecipe(viewModel: RecipesViewModel())
}
