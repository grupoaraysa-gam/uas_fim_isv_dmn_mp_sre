//
//  DetailScreen.swift.swift
//  uas_fim_isv_dmn_mp_sre
//
//  Created by Grupo Araysa on 10/10/26.
//

import SwiftUI

struct DetailScreen: View {
    let student: StudentModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Detalle del Estudiante")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 16) {
                InfoRow(title: "Matrícula:", value: student.matricula)
                Divider()
                InfoRow(title: "Nombre Completo:", value: student.nombre)
                Divider()
                InfoRow(title: "Carrera:", value: student.carrera)
                Divider()
                InfoRow(title: "Turno:", value: student.turno)
                Divider()
                InfoRow(title: "Estatus:", value: student.estatus ? "Activo" : "Inactivo")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
            
            Button(action: {
                dismiss()
            }) {
                Text("Volver al Registro")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(12)
            }
            
            Spacer()
        }
        .padding(24)
        .navigationBarBackButtonHidden(true)
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Spacer()
            Text(value.isEmpty ? "No especificado" : value)
                .font(.body)
                .fontWeight(.medium)
        }
    }
}
