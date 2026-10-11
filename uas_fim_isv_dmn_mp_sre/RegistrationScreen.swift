//
//  RegistrationScreen.swift
//  uas_fim_isv_dmn_mp_sre
//
//  Created by Grupo Araysa on 10/10/26.
//

import SwiftUI

struct RegistrationScreen: View {
    @State private var matricula: String = ""
    @State private var nombre: String = ""
    @State private var carrera: String = "Seleccionar Carrera"
    @State private var turno: String = "Matutino"
    @State private var estatus: Bool = true
    
    @State private var navigateToDetail = false
    @State private var savedStudent: StudentModel? = nil
    
    let carrerasList = ["Ingeniería en Software", "Ingeniería Civil", "Arquitectura", "Derecho", "Administración"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Sistema de Registro")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Divider()
                    
                    // Matrícula
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Matrícula").font(.caption).foregroundColor(.gray)
                        TextField("Ej. 20261001", text: $matricula)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                    }
                    
                    // Nombre Completo
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Nombre Completo").font(.caption).foregroundColor(.gray)
                        TextField("Ej. Juan Pérez", text: $nombre)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.words)
                    }
                    
                    // Carrera (Dropdown / Menu)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Carrera").font(.caption).foregroundColor(.gray)
                        Menu {
                            ForEach(carrerasList, id: \.self) { item in
                                Button(item) { carrera = item }
                            }
                        } label: {
                            HStack {
                                Text(carrera)
                                    .foregroundColor(carrera == "Seleccionar Carrera" ? .gray : .primary)
                                Spacer()
                                Image(systemName: "chevron.down").foregroundColor(.gray)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        }
                    }
                    
                    // Turno (RadioButton / Segmented Picker)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Turno").font(.caption).foregroundColor(.gray)
                        Picker("Turno", selection: $turno) {
                            Text("Matutino").tag("Matutino")
                            Text("Vespertino").tag("Vespertino")
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    // Estatus (Switch)
                    Toggle("Estatus Activo", isOn: $estatus)
                        .font(.body)
                    
                    Spacer().frame(height: 10)
                    
                    // Botón Guardar (Persistencia UserDefaults) y Enviar a Navegación
                    Button(action: {
                        let student = StudentModel(matricula: matricula, nombre: nombre, carrera: carrera, turno: turno, estatus: estatus)
                        saveToUserDefaults(student: student)
                        savedStudent = student
                        navigateToDetail = true
                    }) {
                        Text("Registrar y Ver Detalle")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(12)
                    }
                    .disabled(matricula.isEmpty || nombre.isEmpty)
                    
                    // Botón Cargar último guardado
                    Button(action: {
                        loadFromUserDefaults()
                    }) {
                        Text("Cargar Último Registro")
                            .font(.headline)
                            .foregroundColor(.purple)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.purple, lineWidth: 1.5))
                    }
                }
                .padding(20)
            }
            .navigationDestination(isPresented: $navigateToDetail) {
                if let student = savedStudent {
                    DetailScreen(student: student)
                }
            }
        }
    }
    
    // Guardar con UserDefaults (Persistencia tipo SharedPreferences)
    private func saveToUserDefaults(student: StudentModel) {
        if let encoded = try? JSONEncoder().encode(student) {
            UserDefaults.standard.set(encoded, forKey: "last_student")
        }
    }
    
    // Cargar desde UserDefaults
    private func loadFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "last_student"),
           let decoded = try? JSONDecoder().decode(StudentModel.self, from: data) {
            matricula = decoded.matricula
            nombre = decoded.nombre
            carrera = decoded.carrera
            turno = decoded.turno
            estatus = decoded.estatus
        }
    }
}

#Preview {
    RegistrationScreen()
}
