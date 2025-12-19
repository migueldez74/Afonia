// En: common/Usuario.dart

class Usuario {
  String usuario = "";
  String pass = "";
  String nombre = "";
  String correo = "";

  Usuario({required this.usuario, required this.pass, required this.nombre, required this.correo});

  Map<String, Object?> toMap(){
    return {"usuario":usuario, "pass":pass, "nombre":nombre, "correo":correo};
  }

  // --- AÑADE ESTE CONSTRUCTOR FACTORY ---
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      usuario: map['usuario'] as String,
      pass: map['pass'] as String,
      nombre: map['nombre'] as String,
      correo: map['correo'] as String,
    );
  }
}
