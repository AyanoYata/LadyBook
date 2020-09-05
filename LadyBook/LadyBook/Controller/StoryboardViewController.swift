import UIKit


class StoryboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let firstViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
           let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
           
           // Initialize a FixedPagingViewController and pass
           // in the view controllers.
           let pagingViewController = PagingViewController(viewControllers: [
             firstViewController,
             secondViewController
           ])
           
           // Make sure you add the PagingViewController as a child view
           // controller and contrain it to the edges of the view.
           addChild(pagingViewController)
           view.addSubview(pagingViewController.view)
           view.constrainToEdges(pagingViewController.view)
           pagingViewController.didMove(toParent: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
