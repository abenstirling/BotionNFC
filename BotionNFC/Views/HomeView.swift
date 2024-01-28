import SwiftUI

struct HomeView: View {
    @State private var urlT: String = "https://"
    @FocusState private var isTextFieldFocused: Bool

    
    var body: some View {
        ZStack {
            // Use a background that adapts to light/dark mode
            Color(UIColor.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 15) {
                TextField("https://", text: $urlT)
                                    .focused($isTextFieldFocused) // Bind the focus state to the text field
                                    .disableAutocorrection(true)
                                    .padding()
                                    .font(.headline)
                                    .foregroundColor(Color.primary)
                                    .background(VisualEffectView(effect: UIBlurEffect(style: .systemMaterial)))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 25)
                                    .shadow(color: Color.primary.opacity(0.1), radius: 1, x: 0, y: 2)
                                    .onAppear {
                                        // Set the text field to be focused when the view appears
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            self.isTextFieldFocused = true
                                        }
                                    }
                
                Button(action: {
                    // Implement your NFC writing action here
                    NFCUtility.performAction(.writeData(urlT)) { _ in
                        self.urlT = "https://"
                    }
                }) {
                    Text("Send To Your Card")
                        .padding()
                        .font(.headline)
                        // Button text color adapts to light/dark mode
                        .foregroundColor(Color.primary)
                        .frame(maxWidth: UIScreen.main.bounds.width - 50)
                        // Use a system material background for the button as well
                        .background(VisualEffectView(effect: UIBlurEffect(style: .systemMaterial)))
                        .cornerRadius(10)
                        // Consistent padding and shadow as the TextField
                        .padding(.horizontal, 25)
                        .shadow(color: Color.primary.opacity(0.1), radius: 1, x: 0, y: 2)
                }
            }
        }
    }
}

// Create a VisualEffectView struct to use UIVisualEffectView in SwiftUI
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light) // Remove or change to .dark to test both appearances
    }
}
