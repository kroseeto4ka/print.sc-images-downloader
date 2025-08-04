//
//  WarningPresenter.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/4/25.
//

protocol IWarningPresenter {
    func runFindImageFlow()
}

final class WarningPresenter {
    weak var view: IWarningViewController!
    var router: IWarningRouter
    
    init(router: IWarningRouter) {
        self.router = router
    }
}

extension WarningPresenter: IWarningPresenter {
    func runFindImageFlow() {
        router.routeTo(target: WarningRouter.Target.findImage)
    }
}
