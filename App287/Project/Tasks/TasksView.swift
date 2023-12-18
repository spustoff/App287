//
//  TasksView.swift
//  App287
//
//  Created by Вячеслав on 12/16/23.
//

import SwiftUI

struct TasksView: View {
    
    @StateObject var viewModel = TasksViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Tasks")
                        .foregroundColor(Color("primary"))
                        .font(.system(size: 23, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddTask = true
                        }
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(Color("primary"))
                            .font(.system(size: 19, weight: .semibold))
                    })
                }
                .padding()
                
                if viewModel.tasks.isEmpty {
                    
                    Text("NO TASKS FOUND")
                        .foregroundColor(.gray)
                        .font(.system(size: 18, weight: .regular))
                        .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.tasks, id: \.self) { index in
                            
                                NavigationLink(destination: {
                                    
                                    TaskDetail(index: index)
                                        .navigationBarBackButtonHidden()
                                    
                                }, label: {
                                    
                                    HStack(alignment: .top) {
                                        
                                        VStack(alignment: .leading, spacing: 6, content: {
                                            
                                            Text(index.name ?? "")
                                                .foregroundColor(.white)
                                                .font(.system(size: 18, weight: .medium))
                                            
                                            Text(index.executor ?? "")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 13, weight: .regular))
                                        })
                                        
                                        Spacer()
                                        
                                        Text(index.status ?? "")
                                            .foregroundColor(.green)
                                            .font(.system(size: 14, weight: .regular))
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(.white))
                                    .padding(.horizontal)
                                })
                            }
                        }
                        .padding(1)
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchTasks()
        }
        .overlay (
        
            ZStack {
                
                Color.black.opacity(viewModel.isAddTask ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        UIApplication.shared.endEditing()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddTask = false
                        }
                    }
                
                VStack {
                    
                    Text("New task")
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
                    
                    VStack(alignment: .leading, spacing: 10, content: {
                        
                        Text("Executor")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                        
                        if viewModel.staffs.isEmpty {
                            
                            Text("No any staff you have")
                                .foregroundColor(.gray)
                                .font(.system(size: 13, weight: .regular))
                            
                        } else {
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack {
                                    
                                    ForEach(viewModel.staffs, id: \.self) { index in
        
                                        Button(action: {
                                            
                                            viewModel.executor = index.name ?? ""
                                            
                                        }, label: {
                                            
                                            Text(index.name ?? "")
                                                .foregroundColor(viewModel.executor == index.name ?? "" ? .black : .gray)
                                                .font(.system(size: 14, weight: .regular))
                                                .frame(height: 45)
                                                .padding(.horizontal, 15)
                                                .background(RoundedRectangle(cornerRadius: 10).fill(viewModel.executor == index.name ?? "" ? Color("primary") : .gray.opacity(0.1)))
                                        })
                                    }
                                }
                            }
                        }
                    })
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        
                        Text("Description")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                        
                        TextField("", text: $viewModel.text)
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    
                    Menu {
                        
                        ForEach(viewModel.statuses, id: \.self) { index in
                        
                            Button(action: {
                                
                                viewModel.status = index
                                
                            }, label: {
                                
                                HStack {
                                    
                                    Text(index)
                                    
                                    Spacer()
                                    
                                    if viewModel.status == index {
                                        
                                        Image(systemName: "checkmark")
                                    }
                                }
                            })
                        }
                        
                    } label: {
                        
                        HStack {
                            
                            Text("Status")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            Text(viewModel.status.isEmpty ? "Select" : viewModel.status)
                                .foregroundColor(viewModel.status.isEmpty ? .gray : .white)
                                .font(.system(size: 15, weight: .regular))
                            
                            Spacer()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    }
                    
                    HStack {
                        
                        Text("Comment")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                        
                        TextField("", text: $viewModel.comment)
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    
                    Button(action: {
                        
                        viewModel.addTask()
                        viewModel.fetchTasks()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddTask = false
                        }
                        
                        viewModel.name = ""
                        viewModel.executor = ""
                        viewModel.text = ""
                        viewModel.status = ""
                        viewModel.comment = ""
                        
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
                    .opacity(viewModel.name.isEmpty || viewModel.executor.isEmpty || viewModel.text.isEmpty || viewModel.status.isEmpty || viewModel.comment.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.name.isEmpty || viewModel.executor.isEmpty || viewModel.text.isEmpty || viewModel.status.isEmpty || viewModel.comment.isEmpty ? true : false)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                .padding()
                .offset(y: viewModel.isAddTask ? 0 : UIScreen.main.bounds.height)
                .onAppear {
                    
                    viewModel.fetchStaff()
                }
            }
        )
    }
}

#Preview {
    TasksView()
}
