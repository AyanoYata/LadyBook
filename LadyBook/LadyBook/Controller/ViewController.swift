import UIKit
import Parchment

class ViewController: UIViewController {
    
    let firstViewController = UIViewController()
    let secondViewController = UIViewController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstViewController.title = "タブ1"
        secondViewController.title = "タブ2"
  
        let pagingViewController = PagingViewController(viewControllers: [
          firstViewController,
          secondViewController
        ])
        
        
        // View に追加
        self.addChild(pagingViewController)
        self.view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
         
        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        
    }


}

