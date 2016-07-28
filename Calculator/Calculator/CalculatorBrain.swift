//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by lwang on 16/7/26.
//  Copyright © 2016年 lwang. All rights reserved.
//

import Foundation

class CalculatorBrain{
    enum Op {
        case Operand(Double)
        case UnaryOperation(String,Double->Double)
        case BinaryOperation(String,(Double,Double)->Double)
        
    }
    var opStack = [Op]()
    
    var konwOps = [String:Op]()
    init(){
        konwOps["×"] = Op.BinaryOperation("×") {$0*$1}
        konwOps["-"] = Op.BinaryOperation("-"){$1-$0}
        konwOps["+"] = Op.BinaryOperation("+"){$0+$1}
        konwOps["÷"] = Op.BinaryOperation("÷"){$1/$0}
        konwOps["√"] = Op.UnaryOperation("√",sqrt)
    }
    
    func pushOperand(Operand:Double)->Double? {
        opStack.append(Op.Operand(Operand))
        return evaluate()
    }
    
    func evaluate(ops:[Op]) -> (result:Double?,remailingOps:[Op]){
        if !ops.isEmpty{
            var remailingOps = ops
            let op = remailingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remailingOps)
                
            case .UnaryOperation(_,let operation):
                let operationEvaluation = evaluate(remailingOps)
                if let operand = operationEvaluation.result{
                     return (operation(operand),operationEvaluation.remailingOps)
                }
            case.BinaryOperation(_, let operation):
                let operationEvaluation1 = evaluate(remailingOps)
                if let operand1 = operationEvaluation1.result {
                    let operationEvaluation2 = evaluate(operationEvaluation1.remailingOps)
                    if let operand2 = operationEvaluation2.result {
                        return (operation(operand1,operand2),operationEvaluation2.remailingOps)
                    }
                }
            }
            
        }
        return (nil,ops)
    }
    
    func evaluate() -> Double?{
        let (result, _) = evaluate(opStack)
        return result
    }
    
    func performOperation(symbol:String)->Double? {
        if let operation = konwOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
    
}
