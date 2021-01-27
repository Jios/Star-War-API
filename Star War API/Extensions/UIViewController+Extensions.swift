import UIKit



extension UIViewController
{
    func showSpinnerViewController(_ spinnerVC: SpinnerViewController)
    {
        addChild(spinnerVC)
        spinnerVC.view.frame = view.frame
        view.addSubview(spinnerVC.view)
        spinnerVC.didMove(toParent: self)
    }
    
    func hideSpinnerViewController(_ spinnerVC: SpinnerViewController)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3,
                                      execute: {
                                        
                                        spinnerVC.willMove(toParent: nil)
                                        spinnerVC.view.removeFromSuperview()
                                        spinnerVC.removeFromParent()
                                      })
    }
}


extension UIViewController
{
    func showAlertView(_ message: String?)
    {
        let alert = UIAlertController(title: "Oops!",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        
        DispatchQueue.main.async {
            
            self.present(alert,
                         animated: true,
                         completion: nil)
        }
    }
}
