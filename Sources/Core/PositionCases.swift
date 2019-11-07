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
    case up
    case down
    case straight
}

public enum ShoulderToForearmSubcase {
//    case outstretched   // esticado
    case upFront        //para cima e para frente
    case upStraight     //para cima e reto
    case upTotFront  //para cima totalmente reto(p frente)
    case downFront      //para baixo e para frente
    case downBack       //para baixo e para tras
    case downStraight   //para baixo e reto
    case downTotFront //para baixo totalmente reto(pra frente)
    case reto           // ¯\(°_o)/¯ (╯°□°)╯
    case retoBack         //reto e para tras
    case retoFrente
    case retoTotFront
}

public enum ForearmToHandForearmCase {
    case reto       //reto
    case bentUp     //dobrado pra cima
    case bentDown   //dobrado pra baixo
}

public enum ForearmToHandSubcase {
    case retoOutstretched //reto esticado
    case bentRetoFront  //reto dobrado pra frente
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
    case straightReto   //perna reta e reta pra baixo
    case straightBack   //perna reta más pra trás
    case halfOpenMiddleFront //perna meio aberta e meio pra frente
    case halfOpenReto       //perna meio aberta e reta
    case halfOpenFront      //perna meio aberta e para frente
    case openReto           //perna aberta e reta
    case openMiddleFront    //perna aberta e meio pra frente
    case openFront          //perna aberta pra frente
}

//depende do angulo
public enum KneeToFootCase {
    case straight       //esticada
    case bentOut        //um pouco dobrada
    case bent           //dobrada
    case bentIn         //muito dobrada
}

public enum BothLegsCase {
    
}

