import UIKit
import Parchment

class StoryboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 
                 let firstViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
                 let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
                 
                 
                 let pagingViewController = PagingViewController(viewControllers: [
                   firstViewController,
                   secondViewController
                 ])
              
                 addChild(pagingViewController)
                 view.addSubview(pagingViewController.view)
                 view.constrainToEdges(pagingViewController.view)
                  pagingViewController.didMove(toParent: self)
          
    }
    

    
}

