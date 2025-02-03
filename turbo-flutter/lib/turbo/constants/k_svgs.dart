const kSvgsCheck = 'assets/svgs/check.svg';
const kSvgsHyphen = 'assets/svgs/hyphen.svg';
const kSvgs = ConstSvgs._();

class ConstSvgs {
  const ConstSvgs._();

  static const _email = 'assets/svgs/email.svg';
  String get email => _email;

  static const _check = 'assets/svgs/check.svg';
  String get check => _check;

  static const _hyphen = 'assets/svgs/hyphen.svg';
  String get hyphen => _hyphen;

  static const _logo = 'assets/svgs/logo.svg';
  String get logo => _logo;

  static const _topBlob = 'assets/svgs/top_blob.svg';
  String get topBlob => _topBlob;

  static const _bottomBlob = 'assets/svgs/bottom_blob.svg';
  String get bottomBlob => _bottomBlob;
}
