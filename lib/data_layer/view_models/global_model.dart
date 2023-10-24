class GlobalModel {
  //this model is a global model throuhgout all the app , and it is responsive for:
  // 1. theming
  // 2. reciters
  // 3. internationalization
  // 4. audio operations
  // 5. device dimensions

  // default language for this app is english
  String languageCode = 'en';
  int selectedReciter = 1;
  double deviceHeight = 0;
  double deviceWidth = 0;
}
