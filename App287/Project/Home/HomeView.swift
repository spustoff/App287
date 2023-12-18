//
//  HomeView.swift
//  App287
//
//  Created by Вячеслав on 12/16/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Company")
                    .foregroundColor(Color("primary"))
                    .font(.system(size: 23, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("Secondary Bird")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.white))
                    .padding(.horizontal)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        HStack {
                            
                            Text("Reminder")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 23, weight: .semibold))
                            
                            Spacer()
                            
                            Button(action: {
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isReminderAdd = true
                                }
                                
                            }, label: {
                                
                                Image(systemName: "plus")
                                    .foregroundColor(Color("primary"))
                                    .font(.system(size: 19, weight: .semibold))
                            })
                        }
                        .padding()
                        
                        if viewModel.reminders.isEmpty {
                            
                            Text("You have no reminders")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                            
                        } else {
                            
                            ForEach(viewModel.reminders, id: \.self) { index in
                            
                                HStack {
                                    
                                    VStack(alignment: .leading, spacing: 6, content: {
                                        
                                        Text("Reminder")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18, weight: .semibold))
                                        
                                        Text(index)
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14, weight: .regular))
                                    })
                                    
                                    Spacer()
                                    
                                    Image(systemName: "bell")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 18, weight: .regular))
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                                .background(RoundedRectangle(cornerRadius: 10).stroke(.white))
                                .padding(.horizontal)
                            }
                        }
                        
                        HStack {
                            
                            Text("Workers")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 23, weight: .semibold))
                            
                            Spacer()
                        }
                        .padding()
                        
                        if viewModel.staffs.isEmpty {
                            
                            Text("Add an employee in the 'Staff' tab")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                            
                        } else {
                            
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
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchStaff()
        }
        .overlay (
        
            ZStack {
                
                Color.black.opacity(viewModel.isReminderAdd ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        UIApplication.shared.endEditing()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isReminderAdd = false
                        }
                        
                        viewModel.reminder_field = ""
                    }
                
                VStack {
                    
                    Text("New reminder")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .padding(.bottom, 30)
                    
                    HStack {
                        
                        Text("Comment")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                        
                        TextField("", text: $viewModel.reminder_field)
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    
                    Button(action: {
                        
                        viewModel.addReminder()
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                            .padding(.top, 20)
                    })
                    .opacity(viewModel.reminder_field.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.reminder_field.isEmpty ? true : false)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                .padding()
                .offset(y: viewModel.isReminderAdd ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    HomeView()
}
