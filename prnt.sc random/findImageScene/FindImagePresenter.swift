//
//  FindImagePresenter.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/4/25.
//

protocol IFindImagePresenter {
    
}

final class FindImagePresenter {
    private weak var view: IFindImageViewController!
    let router: IFindImageRouter
    
    init(view: IFindImageViewController, router: IFindImageRouter) {
        self.router = router
        self.view = view
    }
}

extension FindImagePresenter: IFindImagePresenter {
    
}
