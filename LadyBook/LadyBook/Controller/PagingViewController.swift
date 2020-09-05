
import UIKit

class PagingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

/*import UIKit
open class PagingViewController:
UIViewController {

// MARK: Public Properties

/// The size for each of the menu items. _Default:
/// .sizeToFit(minWidth: 150, height: 40)_
public var menuItemSize: PagingMenuItemSize {
  get { return options.menuItemSize }
  set { options.menuItemSize = newValue }
}
  
/// Determine the spacing between the menu items. _Default: 0_
public var menuItemSpacing: CGFloat {
  get { return options.menuItemSpacing }
  set { options.menuItemSpacing = newValue }
}
  
  /// Determine the horizontal constraints of menu item label. _Default: 20_
public var menuItemLabelSpacing: CGFloat {
  get { return options.menuItemLabelSpacing }
  set { options.menuItemLabelSpacing = newValue }
}

/// Determine the insets at around all the menu items. _Default:
/// UIEdgeInsets.zero_
public var menuInsets: UIEdgeInsets {
  get { return options.menuInsets }
  set { options.menuInsets = newValue }
}

/// Determine whether the menu items should be centered when all the
/// items can fit within the bounds of the view. _Default: .left_
public var menuHorizontalAlignment: PagingMenuHorizontalAlignment {
  get { return options.menuHorizontalAlignment }
  set { options.menuHorizontalAlignment = newValue }
}
  
/// Determine the position of the menu relative to the content.
/// _Default: .top_
public var menuPosition: PagingMenuPosition {
  get { return options.menuPosition }
  set { options.menuPosition = newValue }
}

/// Determine the transition behaviour of menu items while scrolling
/// the content. _Default: .scrollAlongside_
public var menuTransition: PagingMenuTransition {
  get { return options.menuTransition }
  set { options.menuTransition = newValue }
}

/// Determine how users can interact with the menu items.
/// _Default: .scrolling_
public var menuInteraction: PagingMenuInteraction {
  get { return options.menuInteraction }
  set { options.menuInteraction = newValue }
}

/// The class type for collection view layout. Override this if you/*
