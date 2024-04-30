import Foundation
import SwiftUI
import UIKit

final class ApplicationCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    func start() {
        showLandingPage()
    }

    private func showLandingPage() {
        let landingPageCoordinator = LandingPageCoordinator(navigationController: navigationController)
        addChildCoordinator(landingPageCoordinator)
        landingPageCoordinator.delegate = self
        landingPageCoordinator.start()
    }
}

extension ApplicationCoordinator: LandingPageCoordinatorDelegate {
    func landingPageCoordinatorShouldPresentRoutes(_ sender: LandingPageCoordinator) {
        let coordinator = AccountConfigCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.delegate = self
        coordinator.start()

        removeChildCoordinator(sender)
    }

    func landingPageCoordinatorShouldPresentSignIn(_: LandingPageCoordinator) {
        let coordinator = SignInCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }

    func landingPageCoordinatorShouldPresentSignUp(_: LandingPageCoordinator) {
        let coordinator = SignUpCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}

extension ApplicationCoordinator: AccountConfigCoordinatorDelegate {
    func accountConfigCoordinatorShouldPresentMenu(_ sender: AccountConfigCoordinator) {
        let coordinator = MenuCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.delegate = self
        coordinator.start()

        removeChildCoordinator(sender)
    }

    func accountConfigCoordinatorShouldPresentAddress(_ sender: AccountConfigCoordinator) {
        // TODO: Implement this method
        let coordinator = CreateAddressCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()

        removeChildCoordinator(sender)
    }

    func accountConfigCoordinatorShouldPresentGroup(_ sender: AccountConfigCoordinator) {
        let coordinator = CreateGroupCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()

        removeChildCoordinator(sender)
    }

    func accountConfigCoordinatorShouldPresentBackpack(_ sender: AccountConfigCoordinator) {
        let coordinator = EmergencyBackpackCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()

        removeChildCoordinator(sender)
    }

    func accountConfigCoordinatorShouldPresentFirstAid(_ sender: AccountConfigCoordinator) {
        let coordinator = FirstAidCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()

        removeChildCoordinator(sender)
    }
}

extension ApplicationCoordinator: MenuCoordinatorDelegate {
    func menuCoordinatorShouldPresentAdress(_: MenuCoordinator) {
        // TODO: Implement this method
    }

    func menuCoordinatorShouldPresentGroups(_ sender: MenuCoordinator) {
        let coordinator = CreateGroupCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()

        removeChildCoordinator(sender)
    }

    func menuCoordinatorShouldPresentBackpack(_ sender: MenuCoordinator) {
        let coordinator = EmergencyBackpackCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()

        removeChildCoordinator(sender)
    }

    func menuCoordinatorShouldPresentCourses(_ sender: MenuCoordinator) {
        let coordinator = FirstAidCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()

        removeChildCoordinator(sender)
    }

    func menuCoordinatorShouldPresentMyAccount(_: MenuCoordinator) {
        // TODO: Implement this method
    }

    func menuCoordinatorShouldPresentSettings(_ sender: MenuCoordinator) {
        let coordinator = SettingsCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()

        removeChildCoordinator(sender)
    }

    func menuCoordinatorShouldPresentAbout(_: MenuCoordinator) {
        let viewController = UIHostingController(rootView: AboutView())
        navigationController.pushViewController(viewController, animated: true)
    }

    func menuCoordinatorShouldPresentSignOut(_: MenuCoordinator) {
        // TODO: Implement this method
    }
}
