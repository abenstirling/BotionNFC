import SwiftUI

struct HomeView: View {
    @State private var urlT: String = "https://"
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                TextField("Enter Text", text: $urlT)
                    .disableAutocorrection(true) // Disable autocorrection
                    .padding()
                    .font(.headline)
                    .frame(maxWidth: UIScreen.main.bounds.width - 50)
                    .background(Color.black)
                    .cornerRadius(30)
                
                Button(action: {
                    // writer.scan(writeData: urlT)
                    NFCUtility.performAction(.writeData(urlT)) { _ in
                      self.urlT = ""
                    }
                }) {
                    Text("Write To Your Stirling Card")
                        .padding()
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: UIScreen.main.bounds.width - 50)
                        .background(Color.white)
                        .cornerRadius(30)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
