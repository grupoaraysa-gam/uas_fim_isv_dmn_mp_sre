//
//  StudentModel.swift.swift
//  uas_fim_isv_dmn_mp_sre
//
//  Created by Grupo Araysa on 10/10/26.
//

import Foundation

struct StudentModel: Codable {
    var matricula: String
    var nombre: String
    var carrera: String
    var turno: String
    var estatus: Bool
}
