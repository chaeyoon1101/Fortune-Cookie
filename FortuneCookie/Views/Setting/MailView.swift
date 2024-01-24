import SwiftUI
import UIKit
import MessageUI

struct MailView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            
            if let error = error {
                self.result = .failure(error)
            } else {
                self.result = .success(result)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = context.coordinator
    
        mail.setToRecipients(["chaeyoon0035@gmail.com"])
        mail.setSubject("문의 사항")
        mail.setMessageBody(mailBodyString, isHTML: false)
        
        return mail
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {

    }
    
    private var mailBodyString: String {
        let string =
        """
        문의 사항 및 앱의 버그, 피드백 사항을 적어주세요.
        
        
        ==============================
        
        아이폰 기종 :
        아이폰 OS : \(UIDevice.current.systemVersion)
        앱 버전 : \(currentAppVersion)
        
        위 정보들은 문제가 발생하는 환경을
        파악하기 위해 사용됩니다.
        
        정보 제공을 원하지 않는다면
        삭제하실 수 있습니다.
        ==============================
        
        """
        
        return string
    }
}

fileprivate var currentAppVersion: String {
    guard let dictionary = Bundle.main.infoDictionary,
          let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
    return version
}
