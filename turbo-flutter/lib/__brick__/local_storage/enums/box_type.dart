enum BoxType {
  localStorageDto,
  ;

  String get id => toString();

  String documentId({required String id}) => '$id-$this';
}
