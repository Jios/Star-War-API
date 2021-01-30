import UIKit



extension UIViewController
{
    func showSpinnerViewController(_ spinnerVC: SpinnerViewController)
    {
        addChild(spinnerVC)
        view.addSubview(spinnerVC.view)
        
        if view.frame == .zero
        {
            spinnerVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            spinnerVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            
            spinnerVC.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            spinnerVC.view.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        }
        else
        {
            spinnerVC.view.frame = view.frame
            spinnerVC.view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.isUserInteractionEnabled = false
        
        spinnerVC.didMove(toParent: self)
    }
    
    func hideSpinnerViewController(_ spinnerVC: SpinnerViewController)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3,
                                      execute: {
                                        
                                        self.view.isUserInteractionEnabled = true
                                        
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
