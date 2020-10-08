import UIKit

class MyTabBar: UITabBar {

    override func sizeThatFits(_ size: CGSize) -> CGSize {
            var size = super.sizeThatFits(size)
            size.height = 80
            return size
        }
}
