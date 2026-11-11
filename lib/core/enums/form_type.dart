enum FormType {
  General('General Form'),
  Food('Food Option Form'),
  PersonInformation('Personal Information');

  const FormType(this.label);

  final String label;

  @override
  String toString() => label;
}