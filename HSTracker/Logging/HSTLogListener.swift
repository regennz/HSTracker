//
//  HSTLogListener.swift
//  HSTracker
//
//  Created by Martin BONNIN on 30/11/2019.
//  Copyright © 2019 Benjamin Michotte. All rights reserved.
//

import Foundation
import kotlin_hslog

class HSTLogListener: HSLogListener {
    private let windowManager: WindowManager
    private let toaster: Toaster
    var currentDeck: kotlin_hslog.Deck?
    var currentDeckIsArena = false
    
    init(windowManager: WindowManager, toaster: Toaster) {
        self.windowManager = windowManager
        self.toaster = toaster
    }

    func bgHeroesShow(game: kotlin_hslog.Game, entities: [kotlin_hslog.Entity]) {
        let view = BgHeroesToastView(frame: NSRect.zero)
        
        let heroes = entities.compactMap {
            $0.card?.dbfId
        }.map {
            String($0)
        }
        view.heroes = heroes
        view.clicked = {
            self.toaster.hide()
        }

        toaster.displayToast(view: view, timeoutMillis: -1)
    }
    
    func onCardGained(cardGained: CardGained) {
        
    }
   
    func bgHeroesHide() {
        toaster.hide()
    }
            
    func onDeckEntries(game: kotlin_hslog.Game, isPlayer: Bool, deckEntries: [DeckEntry]) {
        let heroes = deckEntries.filter {
            $0 is DeckEntry.Hero
        }
        // swiftlint:disable force_cast
        windowManager.battlegroundsOverlay.setHeroes(heroes: heroes as! [DeckEntry.Hero])
        // swiftlint:enable force_cast
    }
    
    func onDeckFound(deck: kotlin_hslog.Deck, deckString: String, isArena: Bool) {
        FreezeHelperKt.freeze(deck)
        currentDeck = deck
        currentDeckIsArena = isArena
    }
    
    func onGameChanged(game: kotlin_hslog.Game) {
        
    }
    
    func onGameEnd(game: kotlin_hslog.Game) {
        
    }
    
    func onGameStart(game: kotlin_hslog.Game) {
        // If we cannot get the player ids from the Mirror, set it here
        let hstGame = AppDelegate.instance().coreManager.game
        if let playerId = Int(game.player?.entity?.PlayerID ?? "") {
            hstGame.player.id = playerId
        }
        if let opponentId = Int(game.opponent?.entity?.PlayerID ?? "") {
            hstGame.opponent.id = opponentId
        }
    }
    
    func onOpponentDeckChanged(deck: kotlin_hslog.Deck) {
        
    }
    
    func onPlayerDeckChanged(deck: kotlin_hslog.Deck) {
        
    }
    
    func onTurn(game: kotlin_hslog.Game, turn: Int32, isPlayer: Bool) {
        
    }

    func onRawGame(gameString: KotlinByteArray, gameStartMillis: Int64) {
        
    }
    
    func onSecrets(possibleSecrets: [PossibleSecret]) {
        
    }
}
