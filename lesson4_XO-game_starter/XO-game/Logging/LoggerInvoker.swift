//
//  LoggerInvoker.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 9/10/20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class LoggerInvoker {
    public static let shared = LoggerInvoker()
    
    private init() {}
    
    
    private var loggeReciever = LoggerReceiver()
    private var batchSize = 5
    private var commands: [LogCommand] = []
    
    
    public func addLogCommand(_ command: LogCommand) {
        commands.append(command)
        executeIfCan()
    }
    
    private func executeIfCan() {
        guard commands.count >= batchSize else { return }
        
        commands.forEach { self.loggeReciever.writeMessageToConsole($0.logMessage) }
        commands = []
    }
}
