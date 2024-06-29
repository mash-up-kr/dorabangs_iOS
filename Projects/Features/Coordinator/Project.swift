import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "Coordinator",
    targets: [
        .make(
            name: "AppCoordinator",
            product: .staticLibrary,
            bundleId: "com.mashup.dorabangs.appCoordinator",
            sources: ["AppCoordinator/**"],
            dependencies: [
                .scene(.splash),
                .coordinator(.tab),
                .spm(.tcaCoordinators)
            ]
        ),
        .make(
            name: "TabCoordinator",
            product: .staticLibrary,
            bundleId: "com.mashup.dorabangs.tabCoordinator",
            sources: ["TabCoordinator/**"],
            dependencies: [
                .coordinator(.home),
                .coordinator(.storageBox),
                .spm(.tcaCoordinators),
                .designSystem
            ]
        ),
        .make(
            name: "HomeCoordinator",
            product: .staticLibrary,
            bundleId: "com.mashup.dorabangs.homeCoordinator",
            sources: ["HomeCoordinator/**"],
            dependencies: [
                .scene(.home),
                .spm(.tcaCoordinators)
            ]
        ),
        .make(
            name: "StorageBoxCoordinator",
            product: .staticLibrary,
            bundleId: "com.mashup.dorabangs.homeCoordinator",
            sources: ["StorageBoxCoordinator/**"],
            dependencies: [
                .scene(.storageBox),
                .spm(.tcaCoordinators),
                .coordinator(.feed)
            ]
        ),
        .make(
            name: "FeedCoordinator",
            product: .staticLibrary,
            bundleId: "com.mashup.dorabangs.feedCoordinator",
            sources: ["FeedCoordinator/**"],
            dependencies: [
                .scene(.feed),
                .spm(.tcaCoordinators)
            ]
        )
    ]
)
