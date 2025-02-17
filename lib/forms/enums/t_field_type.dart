enum TFieldType {
  cameraPath,
  checkbox,
  colorPicker,
  datePicker,
  dateRangePicker,
  filePickerPath,
  numberInput,
  phoneInput,
  radioCard,
  radioGroup,
  select,
  selectMulti,
  slider,
  starRating,
  textArea,
  textInput,
  timePicker,
  toggleGroup,
  toggleSwitch,
  ;

  bool get isCameraPath => this == TFieldType.cameraPath;
  bool get isCheckbox => this == TFieldType.checkbox;
  bool get isColorPicker => this == TFieldType.colorPicker;
  bool get isDatePicker => this == TFieldType.datePicker;
  bool get isDateRangePicker => this == TFieldType.dateRangePicker;
  bool get isFilePickerPath => this == TFieldType.filePickerPath;
  bool get isNumberInput => this == TFieldType.numberInput;
  bool get isPhoneInput => this == TFieldType.phoneInput;
  bool get isRadioCard => this == TFieldType.radioCard;
  bool get isRadioGroup => this == TFieldType.radioGroup;
  bool get isSelect => this == TFieldType.select;
  bool get isSelectMulti => this == TFieldType.selectMulti;
  bool get isSlider => this == TFieldType.slider;
  bool get isStarRating => this == TFieldType.starRating;
  bool get isTextArea => this == TFieldType.textArea;
  bool get isTextInput => this == TFieldType.textInput;
  bool get isTimePicker => this == TFieldType.timePicker;
  bool get isToggleGroup => this == TFieldType.toggleGroup;
  bool get isToggleSwitch => this == TFieldType.toggleSwitch;
}
