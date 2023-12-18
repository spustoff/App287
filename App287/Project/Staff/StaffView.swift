//
//  StaffView.swift
//  App287
//
//  Created by Вячеслав on 12/16/23.
//

import SwiftUI

struct StaffView: View {
    
    @StateObject var viewModel = StaffViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Staff")
                        .foregroundColor(Color("primary"))
                        .font(.system(size: 23, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddStuff = true
                        }
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(Color("primary"))
                            .font(.system(size: 19, weight: .semibold))
                    })
                }
                .padding()
                
                if viewModel.staffs.isEmpty {
                    
                    Text(String("The staff will not find").uppercased())
                        .foregroundColor(.gray)
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.center)
                        .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.staffs, id: \.self) { index in
                            
                                HStack {
                                    
                                    Image(systemName: "person.text.rectangle")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 18, weight: .regular))

                                    
                                    VStack(alignment: .leading, spacing: 6, content: {
                                        
                                        Text(index.name ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18, weight: .semibold))
                                        
                                        Text(index.post ?? "")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14, weight: .regular))
                                    })
                                    
                                    Spacer()
                                    
                                    Text((index.working_from ?? Date()).convertDate(format: "MMM d HH:mm"))
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                                .background(RoundedRectangle(cornerRadius: 10).stroke(.white))
                                .padding(.horizontal)
                            }
                        }
                        .padding(1)
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchStaff()
        }
        .overlay (
        
            ZStack {
                
                Color.black.opacity(viewModel.isAddStuff ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        UIApplication.shared.endEditing()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddStuff = false
                        }
                    }
                
                VStack {
                    
                    Text("New employee")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .padding(.bottom, 30)
                    
                    HStack {
                        
                        Text("Name")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                        
                        TextField("", text: $viewModel.name)
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    
                    HStack {
                        
                        Text("Post")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                        
                        TextField("", text: $viewModel.post)
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    
                    HStack {
                        
                        Text("Working from")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                        
                        Spacer()
                        
                        DatePicker(selection: $viewModel.work_schedule, displayedComponents: .date, label: {})
                            .labelsHidden()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    
                    Button(action: {
                        
                        viewModel.addStaff()
                        viewModel.fetchStaff()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddStuff = false
                        }
                        
                        viewModel.name = ""
                        viewModel.post = ""
                        viewModel.work_schedule = Date()
                        
                        UIApplication.shared.endEditing()
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                            .padding(.top, 20)
                    })
                    .opacity(viewModel.name.isEmpty || viewModel.post.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.name.isEmpty || viewModel.post.isEmpty ? true : false)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                .padding()
                .offset(y: viewModel.isAddStuff ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    StaffView()
}
