//
//  AddExperiment.swift
//  TH_App27
//
//  Created by IGOR on 04/02/2025.
//

import SwiftUI

struct AddExperiment: View {
    
    @StateObject var viewModel: ExperimentsViewModel
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New experiments")
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
                                .opacity(viewModel.exName.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.exName)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                            .padding(.vertical, 5)
                        
                        Text("Idea")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        ZStack(content: {
                            
                            Text("Enter")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.exIdea.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.exIdea)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                            .padding(.vertical, 5)
                            
                            VStack(alignment: .leading, spacing: 14) {
                                
                                Text("Experiment date")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .regular))
                                
                                HStack {
                                    
                                    DatePicker("", selection: $viewModel.exDate, displayedComponents: .date)
                                        .labelsHidden()
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 14) {
                            
                            Text("Comment")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                            
                            ZStack(content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.exComment.isEmpty ? 1 : 0)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                TextField("", text: $viewModel.exComment)
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 16, weight: .regular))
                                
                            })
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(maxWidth: .infinity)
                                .frame(height: 1)
                                .padding(.vertical, 5)
                            
                        }
                        .padding(.bottom)

                        HStack {
                            
                            ForEach(viewModel.statuses, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.currStatus = index
                                    
                                }, label: {
                                    
                                    Text(index)
                                        .foregroundColor(.black)
                                        .font(.system(size: 15, weight: .regular))
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 30)
                                        .background(RoundedRectangle(cornerRadius: 7).fill(Color("prim2").opacity(viewModel.currStatus == index ? 1 : 0)))
                                })
                            }
                        }
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color("prim1")))
                    }
                    .padding(.bottom, 80)
                                        
                    Button(action: {
                        
                        viewModel.exStatus = viewModel.currStatus
                        
                        viewModel.addExperiment()
                        
                        viewModel.exName = ""
                        viewModel.exComment = ""
                        viewModel.exIdea = ""
                        
                        viewModel.fetchExperiments()
                        
                        viewModel.currStatus = ""
                        
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
                    .opacity(viewModel.currStatus.isEmpty || viewModel.exName.isEmpty || viewModel.exIdea.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.currStatus.isEmpty || viewModel.exName.isEmpty || viewModel.exIdea.isEmpty ? true : false)
                }
            }
            .padding()
        }
    }
}

#Preview {
    AddExperiment(viewModel: ExperimentsViewModel())
}
