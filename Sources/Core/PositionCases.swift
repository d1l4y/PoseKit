//
//  PositionCases.swift
//  poseKit-iOS
//
//  Created by Vinicius Dilay on 07/11/19.
//  Copyright © 2019 d1l4y. All rights reserved.
//

import Foundation

///ArmCases
public enum ShoulderToForearmCase {
    case verticalUp
    case verticalDown
    case horizontal
}

public enum ShoulderToForearmSubcase {
//    case outstretched   // esticado
    case verticalUpDiagonalFront     //para cima e para frente
    case verticalUpParallel     //para cima e reto
    case verticalUpTransverse  //para cima totalmente reto(p frente)
    case verticalDownDiagonalFront      //para baixo e para frente
    case verticalDownDiagonalBack       //para baixo e para tras
    case verticalDownParallel   //para baixo e reto
    case verticalDownTransverse //para baixo totalmente reto(pra frente)
    case horizontalParallel       // ¯\(°_o)/¯ (╯°□°)╯
    case horizontalDiagonalBack         //reto e para tras
    case horizontalDiagonalFront
    case horizontalTransverse
}

public enum ForearmToHandForearmCase {
    case straightHorizontal       //reto
    case bentUp     //dobrado pra cima
    case bentDown   //dobrado pra baixo
}

public enum ForearmToHandSubcase {
    case straightHorizontal //reto esticado
    case horizontalBentIn //reto dobrado pra frente
    case bentUp         //dobrado pra cima-reto
    case bentUpOut      //dobrado pra cima-fora
    case bentUpIn       //dobrado pra cima-dentro
    case bentDown       //dobrado pra baixo-reto
    case bentDownOut    //dobrado pra baixo-fora
    case bentDownIn     //dobrado pra baixo-dentro
}


///legCases
public enum LegToKneeCase {
    case straight //perna reta
    case halfOpen //perna meio-aberta
    case Open     //perna totalmente aberta
}

//depende do eixo y e z
public enum LegToKneeSubcase {
    case straightParallel   //perna reta e reta pra baixo
    case straightBack   //perna reta más pra trás
    case halfOpenDiagonal //perna meio aberta e meio pra frente
    case halfOpenParallel       //perna meio aberta e reta
    case halfOpenTransversal      //perna meio aberta e para frente
    case openParallel           //perna aberta e reta
    case openDiagonal    //perna aberta e meio pra frente
    case openTransversal          //perna aberta pra frente
}

//depende do angulo
public enum KneeToFootCase {
    case outstretched       //esticada
    case bentOut        //um pouco dobrada
    case bent           //dobrada
    case bentIn         //muito dobrada
}

public enum BothLegsCase {
    
}


