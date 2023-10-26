class Reciters {
  static List<Reciter> reciters = [
    Reciter(1, 'AbdulBaset-Mujawwad'),
    Reciter(2, 'AbdulBaset-Murattal '),
    Reciter(3, 'Sudais'),
    Reciter(4, 'Shatri'),
    Reciter(5, 'Rifai'),
    Reciter(6, 'Husary'),
    Reciter(7, 'Alafasy'),
    Reciter(8, 'Minshawi-Mujawwad'),
    Reciter(9, 'Minshawi-Murattal'),
    Reciter(10, 'Shuraym'),
    Reciter(11, 'Mohammad al Tablaway'),
    Reciter(12, 'Husary-Muallim'),
  ];
}

class Reciter {
  int id;
  String name;
  Reciter(this.id, this.name);
}
