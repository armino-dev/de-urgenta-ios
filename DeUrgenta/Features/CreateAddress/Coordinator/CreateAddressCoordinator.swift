import Foundation
import MessageUI
import SwiftUI
import UIKit

final class CreateAddressCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    var viewModel: CreateAddressViewModel = .init()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UIHostingController(rootView: CreateAddressView())
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension CreateAddressCoordinator: CreateAddressViewDelegate {
    func createAddressViewDidTapAddAddress(_: CreateAddressView) {}

    func createAddressViewDidTapNoAddAddress(_ view: CreateAddressView) {
        let viewController = UIHostingController(rootView: view)
        navigationController.pushViewController(viewController, animated: true)
    }

    func createAddressViewDidTapNoAddress(_: CreateAddressView) {
        navigationController.popViewController(animated: true)
    }
}
