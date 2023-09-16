//
//  UserListView.swift
//  DataService
//
//  Created by Tim Yoon on 6/11/23.
//
//  SwiftUI
//  Decouple peristence (DataService) from ViewModel
//  Combine framework and Dependency Injection
//  MVVM Example
//
//  MockDataService and UserDefaultDataService
//  Could be easily extended to Firebase Firestore or CoreData


import SwiftUI
import Combine
import Charts

struct CheckInListView: View {
    @ObservedObject var vm: CheckInViewModel
    @State private var isShowingSheet = false
    
   

    @StateObject var uservm = UserDataViewModel(ds: UserFirebaseDataService())
    
    var body: some View {
        
        VStack{
            
            
            Chart{
                ForEach(vm.checkins){checkin in
                    BarMark (x:.value("Day", checkin.date, unit: .weekday ),
                             y: .value("Rating", checkin.day1to10))
                    
                }
            }.frame(width: 375, height: 180)
            .chartYScale(domain: 0...10)
            .chartXAxis{
             
                    AxisMarks(values: vm.checkins.map{ $0.date}){date in
                        AxisValueLabel(format: .dateTime.weekday())
                    
                }
            }
            
            VStack {
                Text("\(uservm.userData.streak)")
                      
                Text("\(uservm.userData.lastcheckin)")
                
                }
            
            
     
            
            VStack{
                
                
                NavigationStack {
                    
                    
                    
                    VStack{
                        Text("Checkin" )
                    }
                    
                    
                    VStack{
                       
                    ScrollView{
                        
                        

                            ForEach(vm.checkins.reversed()) { checkin in
                                HStack{
                                  
                                    NavigationLink(destination: CheckInEditView(checkin: checkin, save: { returnedCheckIn in
                                        vm.update(checkin: returnedCheckIn)
                                    }, uservm: uservm)) {
                                        // Your NavigationLink content
                                    

                                    
                                        HStack{
                                            Text("\(checkin.day1to10) \(checkin.formattedDate())")
                                                .foregroundColor(.black)
                                                .bold()
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.00000000001)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                        }
                                        .padding(.leading, 8)
                                        
                                        
                                    }
                                    
                                    HStack{
                                        
                                        Menu {
                                            Button(role: .destructive) {
                                                
                                                vm.delete(checkin: checkin)
                                                
                                                
                                                    
                                                
                                            } label: {
                                                Image(systemName: "trash")
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                    .foregroundColor(.red)
                                                    .cornerRadius(10)
                                                    .multilineTextAlignment(.center)
                                                Text("Delete Checkin")
                                                
                                                
                                            }
                                            
                                            
                                            
                                            
                                            
                                        } label: {
                                            Image(systemName: "trash")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.black)
                                                .cornerRadius(10)
                                                .multilineTextAlignment(.center)
                                            
                                            
                                        }
                                    }
                                    .frame(maxWidth: 120, alignment: .trailing)
                                    .padding(.trailing, 10)

                                    
                                    
                                    
                                }
                                .frame(width: 350, height: 50)
                                .background(getBackgroundColor(checkin:checkin))
                              
                                
                                .cornerRadius(10)
                                
                                
               
                      
                                
                                
                            }
                        }
                        
                    }
                    
                    
                    Button {
                        
                                isShowingSheet.toggle()
                    } label: {
                     Text("ADD")
                        
                      
                     
                    
                    }

                    
                    
                    .sheet(isPresented: $isShowingSheet) {
                        NavigationStack {
                            CheckInEditView(checkin: CheckIn(), save: { returnedCheckIn in
                                vm.add(checkin: returnedCheckIn)
                            }, uservm: uservm)
                            .navigationTitle("Add Checkin")
                        }
                    }

                }
            }
            
        }
       
              
        
        
    }
    
    
    
    
    func getBackgroundColor(checkin: CheckIn) -> Color {
        switch checkin.day1to10 {
        case 0...3:
            return Color.red
        case 4...7:
            return Color.orange
        case 8...10:
            return Color.green
        default:
            return Color.gray
        }
    }
    
    

}


