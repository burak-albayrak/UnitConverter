//
//  MailViewIPad.swift
//  UnitConverterIPad
//
//  Created by Burak Albayrak on 21.10.2024.
//

import SwiftUI
import MessageUI

struct MailViewIPad: UIViewControllerRepresentable {
    @Binding var result: Result<MFMailComposeResult, Error>?
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.horizontalSizeClass) var sizeClass
    let configure: (MFMailComposeViewController) -> Void
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = context.coordinator
        configure(composer)
        
        // iPad için ek yapılandırma
        if sizeClass == .regular {
            composer.modalPresentationStyle = .formSheet
        }
        
        return composer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailViewIPad
        
        init(_ parent: MailViewIPad) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            if let error = error {
                parent.result = .failure(error)
            } else {
                parent.result = .success(result)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct MailView_Previews: PreviewProvider {
    static var previews: some View {
        MailViewIPad(result: .constant(nil)) { _ in }
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (5th generation)"))
            .previewDisplayName("iPad Pro")
    }
}
