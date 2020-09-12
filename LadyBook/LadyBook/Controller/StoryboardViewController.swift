import UIKit
import Parchment

class StoryboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 
                 let firstViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
                 let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
                 let thirdViewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController")
                 let forthViewController = storyboard.instantiateViewController(withIdentifier: "ForthViewController")
                 
                 
                 let pagingViewController = PagingViewController(viewControllers: [
                   firstViewController,secondViewController,thirdViewController
                 ])
              
                 addChild(pagingViewController)
                 view.addSubview(pagingViewController.view)
                 view.constrainToEdges(pagingViewController.view)
                  pagingViewController.didMove(toParent: self)
          
    }
}

