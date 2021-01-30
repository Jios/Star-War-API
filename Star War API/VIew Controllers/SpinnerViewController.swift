import UIKit



class SpinnerViewController: UIViewController
{
    var spinner = UIActivityIndicatorView(style: .large)
    
    override func didMove(toParent parent: UIViewController?)
    {
        super.didMove(toParent: parent)
        
        view = UIView()
        view.backgroundColor = UIColor(white: 0,
                                       alpha: 0.3)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
