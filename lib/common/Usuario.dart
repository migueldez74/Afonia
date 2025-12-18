class Usuario {
  String usuario = "";
  String pass = "";
  String nombre = "";
  String correo = "";

  Usuario({required this.usuario, required this.pass, required this.nombre, required this.correo});

  Map<String, Object?> toMap(){
    return {"usuario":usuario, "contras":pass, "nombre":nombre, "correo":correo};
  }
}