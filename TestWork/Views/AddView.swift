//
//  AddView.swift
//  TestWork
//
//  Created by Вова Дю on 28.05.2021.
//  Copyright © 2021 iMac. All rights reserved.
//

import SwiftUI

struct AddView: View {
  
  @ObservedObject var contractorsModel = ContractorsModel()
  @State var name: String = ""
  @State var contactNumber: String = ""
  @State var email: String = ""
  @State var image: String = ""
//  @Environment(\.presentationMode) var presentation
  @Binding var isPresented: Bool 



  
    var body: some View {
      NavigationView{
        VStack(alignment: .center, spacing: 40){
          TextField("Name", text: $name)
          TextField("contactNumber", text: $contactNumber)
          TextField("email", text: $email).autocapitalization(.none)
           .border(Color(UIColor.separator))
          TextField("image", text: $image).autocapitalization(.none)
          Button(action: {
            self.contractorsModel.addNewContractor(name: self.name, number: self.contactNumber, image: self.image, email: self.email)
            self.isPresented = false
    //        self.presentation.wrappedValue.dismiss()

          }, label: { Text("add")})
          Spacer()
          
          }.textFieldStyle(RoundedBorderTextFieldStyle())

      .navigationBarTitle("Add contractor")
      }
    }
}


//struct AddView_Previews: PreviewProvider {
//    static var previews: some View {
//      AddView(isPresented: Bool)
//    }
//}
