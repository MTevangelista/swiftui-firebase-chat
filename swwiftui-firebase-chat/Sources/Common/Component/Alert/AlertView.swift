import SwiftUI

struct AlertView: View {
    var value: String
    
    var body: some View {
        Text("")
            .alert(isPresented: .constant(true), content: {
                Alert(title: Text(R.string.localizable.chatApp()),
                      message: Text(value),
                      dismissButton: .default(Text(R.string.localizable.ok())))
            })
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(value: R.string.localizable.somethingWrongHappened())
    }
}
