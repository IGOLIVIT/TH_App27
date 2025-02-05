//
//  AddSale.swift
//  TH_App27
//
//  Created by IGOR on 04/02/2025.
//

import SwiftUI

struct AddSale: View {
    
    @StateObject var viewModel: SalesViewModel
    
    var body: some View {

        ZStack {
            
            Color("prim1")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New sale")
                        .foregroundColor(.black)
                        .font(.system(size: 22, weight: .regular))
                 
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = false
                        }
                        
                    }, label: {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .medium))
                    })
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.bottom, 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 18) {
                        
                        Text("Recipes name")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        ZStack(content: {
                            
                            Text("Enter")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.saName.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.saName)
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
                                
                                Text("Date of sale")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
                                
                                HStack {
                                    
                                    DatePicker("", selection: $viewModel.saDate, displayedComponents: .date)
                                        .labelsHidden()
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack(alignment: .leading, spacing: 14) {
                                
                                Text("Quantity sold")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
                                
                                HStack {
                                    
                                    ZStack(content: {
                                        
                                        Text("0")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 15, weight: .regular))
                                            .opacity(viewModel.saQuan.isEmpty ? 1 : 0)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        TextField("", text: $viewModel.saQuan)
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 16, weight: .regular))
                                        
                                    })
                                    .padding(6)
                                    
                                    Text("pcs")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                }
                            }
                            
                        }
                        
                        Text("Revenue")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        HStack {
                            
                            ZStack(content: {
                                
                                Text("0")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.saRev.isEmpty ? 1 : 0)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                TextField("", text: $viewModel.saRev)
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 16, weight: .regular))
                                
                            })
                            
                         Spacer()
                            
                            Text("$")
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                        }
                        .padding(.bottom, 90)
                        
                        Button(action: {
                            
                            viewModel.TotalSold += Int(viewModel.saQuan) ?? 0
                            viewModel.Revenue += Int(viewModel.saRev) ?? 0
                            
                            viewModel.addSale()
                            
                            viewModel.saName = ""
                            viewModel.saQuan = ""
                            viewModel.saRev = ""
                            
                            viewModel.fetchSales()
                            
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
                        .opacity(viewModel.saName.isEmpty || viewModel.saQuan.isEmpty || viewModel.saRev.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.saName.isEmpty || viewModel.saQuan.isEmpty || viewModel.saRev.isEmpty ? true : false)
                    }
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    AddSale(viewModel: SalesViewModel())
}
